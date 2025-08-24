# Import required libraries
import pandas as pd
import dash
#import dash_html_components as html
from dash import html
#import dash_core_components as dcc
from dash import dcc
from dash.dependencies import Input, Output
import plotly.express as px



# Read data into pandas dataframe
#spacex_df = pd.read_csv("spacex_launch_dash.csv")
spacex_df = pd.read_csv(r"C:\Users\Lenovo\Downloads\Applied data science - IBM\3. Md 3\spacex_launch_dash.csv")

#info from dataset
#launch sites: 'CCAFS LC-40', 'VAFB SLC-4E', 'KSC LC-39A', 'CCAFS SLC-40'
#booster version category: ['v1.0', 'v1.1', 'FT', 'B4', 'B5']

max_payload = spacex_df['Payload Mass (kg)'].max()
min_payload = spacex_df['Payload Mass (kg)'].min()

# Create a dash application
app = dash.Dash(__name__)


# Create an app layout
app.layout = html.Div(children=[html.H1('SpaceX Launch Records Dashboard',
                                        style={'textAlign': 'center', 'color': '#503D36',
                                               'fontSize': 40}),   # <-- fixed font-size
                                dcc.Dropdown(id='site-dropdown', 
                                    options=[{'label':'All Sites', 'value':'ALL'}, 
                                            {'label':'CCAFS LC-40', 'value':'CCAFS LC-40'},
                                            {'label':'VAFB SLC-4E', 'value':'VAFB SLC-4E'},
                                            {'label':'KSC LC-39A', 'value':'KSC LC-39A'},
                                            {'label':'CCAFS SLC-40', 'value':'CCAFS SLC-40'}],
                                    value='ALL', 
                                    placeholder='Select a Launch Site here', 
                                    searchable=True
                                    ),
                                html.Br(),
                                html.Div(dcc.Graph(id='success-pie-chart')),
                                html.Br(),
                                html.P("Payload range (Kg):"),
                                dcc.RangeSlider(id='payload-slider',
                                    min=0,
                                    max=10000,
                                    step=1000,
                                    value=[0, 10000]
                                ),
                                html.Div(dcc.Graph(id='success-payload-scatter-chart')),
                                ])


# TASK 2: pie chart callback
@app.callback(Output('success-pie-chart', 'figure'), 
            Input('site-dropdown', 'value'))
def get_pie_chart(entered_site):
    chart_data = spacex_df.groupby('Launch Site')
    chart1 = chart_data['class'].sum() / sum(chart_data['class'].sum())
    chart2 = chart_data['class'].sum() / chart_data['class'].count()

    if entered_site == 'ALL':
        data = chart1.values
        labels = chart1.index
        fig = px.pie(values=data, names=labels, title='Success rate for all launch sites')
        return fig
    else:
        data = [chart2[entered_site], 1-chart2[entered_site]]
        labels = ['Success', 'Failure']   # <-- fixed labels
        fig = px.pie(values=data, names=labels, title=f'Success rate for {entered_site}')
        return fig


# TASK 4: scatter chart callback
@app.callback(Output('success-payload-scatter-chart', 'figure'),
            [Input('site-dropdown', 'value'),
             Input('payload-slider', 'value')])
def get_scatter_chart(entered_site, entered_payload):
    df = spacex_df
    low, high = entered_payload
    mask = (df['Payload Mass (kg)'] >= low) & (df['Payload Mass (kg)'] <= high)

    if entered_site == 'ALL':
        fig = px.scatter(df[mask],    # <-- added payload filter
            x='Payload Mass (kg)', y='class', color='Booster Version Category')
        return fig
    else:
        mask = mask & (df['Launch Site']== entered_site)
        fig = px.scatter(df[mask], 
            x='Payload Mass (kg)', y='class', color='Booster Version Category')
        return fig

# # Run the app # Running the app from local vs code
if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8051, debug=True)


#if __name__ == '__main__': # code outside machine # Not working in local vs code
    #app.run(host='0.0.0.0', port=8051, debug=True)
