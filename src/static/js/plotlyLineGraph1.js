var { color_func
    , color_sel_val
    , color_lin_c
    , margin_l
    , margin_r
    , margin_b
    , margin_t
    } = require( './plotSettings.js' );

var plotly = require( './plotlyUtils.js' );
var plotlyShow = new plotly.Marker();


// https://addyosmani.com/resources/essentialjsdesignpatterns/book/
var plotlyLineGraph1 = (function () {

    function publicMakeGraph(dataGraph, marker_, callback) {

        var dataX = dataGraph[0].x_date,
            dataY = dataGraph[0].y_high,
            text_hover = dataGraph[0].text,
            selected_day_id = dataGraph[1],
            css_id_row_hover = dataGraph[0].idSelectorRows;
            css_id_title_hover = dataGraph[0].idSelectorTitle;
            css_id_graphs = dataGraph[0].idSelectorGraphTemperatures;

        var linePlot = document.getElementById(css_id_graphs.lineGraphTemperatures);

        var num = dataX.length;

        var minX = dataX[0],
            maxX = dataX[num-1],
            minY = Math.min.apply(null, dataY),
            maxY = Math.max.apply(null, dataY);

        var trace1 = {
                type: 'scatter',
                text: text_hover,
                x: dataX.map(function(val) {
                    return val.substring(0,6);
                }),
                y: dataY,
                sel_day_id: selected_day_id,
                marker: marker_
            };

        var data = [trace1];

        var layout = {
                xaxis: {
                    tickangle: 45,
                    nticks: 10,
                    showgrid: true,
                    showline: true,
                    rangemode: 'tozero',
                    // range: [minX - 1, maxX + 1],
                    range: [-0.5, 9.5],
                    gridwidth: 1,
                    hoverformat: '.2f',
                },
                yaxis: {
                    title: 'Temperature',
                    showgrid: true,
                    showline: true,
                    range: [0, maxY + 3],
                    gridwidth: 2,
                    hoverformat: '.2f',
                    autotick: false,
                    tick0: 0,
                    dtick: 5,
                },
                margin: {
                    l: margin_l,
                    r: margin_r,
                    b: margin_b,
                    t: margin_t,
                    // pad: margin_pad
                },
                hovermode:'closest',
                // paper_bgcolor: bgcolor_paper,
                // plot_bgcolor: bgcolor_plot
                annotations: [
                    // {
                    //     xref: 'paper',
                    //     yref: 'paper',
                    //     x: 1,
                    //     xanchor: 'right',
                    //     y: 0,
                    //     yanchor: 'bottom',
                    //     text: 'X axis label',
                    //     showarrow: false
                    // },
                    {
                        xref: 'paper',
                        yref: 'paper',
                        x: 0,
                        xanchor: 'right',
                        y: 1,
                        yanchor: 'bottom',
                        text: '[°C]',
                        showarrow: false
                    }
                ]
            };

        Plotly.newPlot(
            css_id_graphs.lineGraphTemperatures,
            data,
            layout,
            {displayModeBar: false}
        );


        linePlot.on('plotly_hover', function (data){
            var selected_day = data.points[0].pointNumber;
            plotlyShow.hoverly('hover', selected_day, marker_, css_id_graphs);

            // making sure the Callback is a function
            if (callback && typeof(callback) === "function") {
                callback(selected_day);
            }
        });


        linePlot.on('plotly_unhover', function(data){
            var selected_day = data.points[0].pointNumber;
            plotlyShow.hoverly('unhover', selected_day, marker_, css_id_graphs);

            // making sure the Callback is a function
            if (callback && typeof(callback) === "function") {
                callback(-1);
            }
        });


        if (selected_day_id == 0) {
            hoverCardForecast = document.getElementById(css_id_title_hover);
        } else {
            hoverCardForecast = document.getElementById(css_id_row_hover);
        }

        
        if (hoverCardForecast) {
            hoverCardForecast.addEventListener(
                'mouseover',
                plotlyShow.hoverly('hover', data[0].sel_day_id, marker_, css_id_graphs),
                false
            );
        }
    };

    return {
        makeGraph: publicMakeGraph
    };

})();

module.exports = plotlyLineGraph1;
