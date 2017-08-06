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
var plotlyBarGraph1 = (function () {

    function publicMakeGraph(dataGraph, marker_, callback) {

        var dataX = dataGraph[0].x_date,
            dataY = dataGraph[0].y_high,
            dataYlow = dataGraph[0].y_low,
            text_hover = dataGraph[0].text,
            selected_day_id = dataGraph[1],
            css_id_row_hover = dataGraph[0].idSelectorRows;
            css_id_title_hover = dataGraph[0].idSelectorTitle;
            css_id_graphs = dataGraph[0].idSelectorGraphTemperatures;

        var barPlot = document.getElementById(css_id_graphs.barGraphTemperatures);

        var num = dataX.length;

        var minY = Math.min.apply(null, dataY),
            maxY = Math.max.apply(null, dataY);

        var trace1 = {
                type: 'bar',
                x: dataX.map(function(val) {
                    return val.substring(0,6);
                }),
                y: dataY,
                sel_day_id: selected_day_id,
                marker: marker_,
            };

        var trace2 = {
                type: 'bar',
                x: dataX.map(function(val) {
                    return val.substring(0,6);
                }),
                y: dataYlow,
                // sel_day_id: selected_day_id,
            };

        var data = [trace1];

        var layout = {
                barmode: 'group',
                // title: 'Plotly Bar',
                showlegend: false,
                xaxis: {
                    tickangle: 45,
                    showgrid: true,
                    gridwidth: 1,
                    range: [-1, 10],
                    // tickfont: {
                    //     family: 'Arial, sans-serif',
                    //     size: 12,
                    // },
                    // range: [-0.5, 4.5],
                    // tickvals: [0, 1, 2, 3, 4],
                    // ticktext: ['A', 'B', 'C', 'D', 'E']
                },
                yaxis: {
                    title: 'Temperature',
                    showgrid: true,
                    showline: true,
                    range: [0, maxY + 3],
                    gridwidth: 2,
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
                // paper_bgcolor: color_bg_paper,
                // plot_bgcolor: color_bg_plot
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

        // var layout = Object.assign({}, layout1, layout);
        Plotly.newPlot(
            css_id_graphs.barGraphTemperatures,
            data,
            layout
        );


        barPlot.on('plotly_hover', function (data){
            var selected_day = data.points[0].pointNumber;
            plotlyShow.hoverly('hover', selected_day, marker_, css_id_graphs);

            // making sure the Callback is a function
            if (callback && typeof(callback) === "function") {
                callback(selected_day);
            }
        });


        barPlot.on('plotly_unhover', function(data){
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

module.exports = plotlyBarGraph1;
