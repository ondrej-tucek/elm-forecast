
// https://stackoverflow.com/questions/8595509/how-do-you-share-constants-in-nodejs-modules
function define(name, value) {
    Object.defineProperty(exports, name, {
        value:      value,
        enumerable: true
    });
}

define("color_func", '#1F77B4');
define("color_sel_val", '#C54C82');
define("color_lin_c", '#343436');
define("color_bg_paper", '#7f7f7f');
define("color_bg_plot", '#c7c7c7');

define("margin_l", 60);
define("margin_r", 30);
define("margin_b", 60);
define("margin_t", 50);
define("margin_pad", 4);


// module.exports = Object.freeze({
//     color_func: '#1F77B4',
//     color_sel_pnt: '#C54C82',
//     color_lin_c: '#343436',
//     color_bg_paper: '#7f7f7f',
//     color_bg_plot: '#c7c7c7',
//     margin_l: 30,
//     margin_r: 30,
//     margin_b: 30,
//     margin_t: 30,
//     margin_pad: 4
// });
