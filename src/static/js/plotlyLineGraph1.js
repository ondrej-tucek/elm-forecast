var { color_func
    , color_sel_pnt
    , color_lin_c
    , margin_l
    , margin_r
    , margin_b
    , margin_t
    } = require( './plotSettings.js' );


// https://addyosmani.com/resources/essentialjsdesignpatterns/book/
var plotlyLineGraph1 = (function () {

    function publicMakeGraph(dataGraph, callback) {

        var myPlot = document.getElementById('lineGraph1'),
            rowItems = document.getElementById('row-items__hover');

        var dataX = dataGraph[0][0],
            dataY = dataGraph[0][1];
            selectedDayId = dataGraph[1];

        var num = dataX.length;

        var marker_size = Array(num).fill(10),
            marker_lin_c = Array(num).fill(color_lin_c),
            marker_line_w = Array(num).fill(1.5),
            marker_opacity = Array(num).fill(1),
            marker_color = Array(num).fill(color_func);

        var minX = dataX[0],
            maxX = dataX[num-1],
            minY = Math.min.apply(null, dataY),
            maxY = Math.max.apply(null, dataY);

        var trace1 = {
            x: dataX,
            y: dataY,
            selDayId: selectedDayId,

            marker: {
                // size: 10,
                size: marker_size,
                line: {
                    color: marker_lin_c,
                    width: marker_line_w
                },
                opacity: marker_opacity,
                color: marker_color
            },
            type: 'scatter',
            text: dataGraph[0][3]
        };

        var layout1 = {
            xaxis: {
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
        };

        var data = [trace1];



        Plotly.newPlot('lineGraph1', data, layout1, {displayModeBar: false});
        // Plotly.plot(myPlot, data, layout1, {displayModeBar: false});


        function hoverly(type_hover, selected_value){
            if (type_hover == 'hover') {
                marker_size[selected_value] = 16;
                marker_opacity[selected_value] = 1;
                marker_color[selected_value] = color_sel_pnt;
            } else {
                marker_size[selected_value] = 10;
                marker_opacity[selected_value] = 1;
                marker_color[selected_value] = color_func;
            }

            var update = {
                'marker': {
                    color: marker_color,
                    size: marker_size,
                    opacity: marker_opacity,
                    line: {
                        color: marker_lin_c,
                        width: marker_line_w
                    }
                }
            };

            Plotly.restyle('lineGraph1', update);
        };


        if(rowItems){
            rowItems.addEventListener('mouseover', hoverly('hover', data[0].selDayId), false);
        }


        myPlot.on('plotly_hover', function (data){
            var selected_day = data.points[0].pointNumber;
            hoverly('hover', selected_day);

            // making sure the Callback is a function
            if (callback && typeof(callback) === "function") {
                callback(selected_day);
            }
        });


        myPlot.on('plotly_unhover', function(data){
            var selected_day = data.points[0].pointNumber;
            hoverly('unhover', selected_day);

            // making sure the Callback is a function
            if (callback && typeof(callback) === "function") {
                callback(-1);
            }
        });
    };


    return {
        makeGraph: publicMakeGraph
    };

})();

module.exports = plotlyLineGraph1;
