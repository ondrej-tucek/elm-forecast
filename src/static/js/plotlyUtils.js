var { color_func
    , color_sel_val
    , color_lin_c
    , margin_l
    , margin_r
    , margin_b
    , margin_t
    } = require( './plotSettings.js' );


var Marker = function() {
    function init(num) {
        return {
            size: Array(num).fill(10),
            color: Array(num).fill(color_func),
            opacity: Array(num).fill(1),
            line: {
                color: Array(num).fill(color_lin_c),
                width: Array(num).fill(1.5)
            }
        };
    };

    function hoverly(type_hover, selected_value, update_marker, css_id_graphs) {
        if (type_hover == 'hover') {
            update_marker.size[selected_value] = 16;
            update_marker.opacity[selected_value] = 1;
            update_marker.color[selected_value] = color_sel_val;
        } else {
            update_marker.size[selected_value] = 10;
            update_marker.opacity[selected_value] = 1;
            update_marker.color[selected_value] = color_func;
        }

        var update = {
            'marker': update_marker
        };

        Plotly.restyle(css_id_graphs.lineGraphTemperatures, update);
        Plotly.restyle(css_id_graphs.barGraphTemperatures, update);
    };

    return {
        init,
        hoverly
    };
};

module.exports = {Marker};
