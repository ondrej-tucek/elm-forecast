// pull in desired CSS/SASS files
require( './styles/main.scss' );
// require( '../../node_modules/weather-icons/sass/weather-icons.scss' );
var $ = jQuery = require( '../../node_modules/jquery/dist/jquery.js' );           // <--- remove if jQuery not needed
require( '../../node_modules/bootstrap-sass/assets/javascripts/bootstrap.js' );   // <--- remove if Bootstrap's JS not needed

// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
var app = Elm.Main.embed( document.getElementById( 'main' ) );

var plotly = require( './js/plotlyUtils.js' );
var plotlyLineGraph1 = require( './js/plotlyLineGraph1.js' );
var plotlyBarGraph1 = require( './js/plotlyBarGraph1.js' );

var plotlyMarker = new plotly.Marker();
var data = [null, null];


function plot(data) {
    marker_settings = plotlyMarker.init(data[0].x_date.length);

    plotlyLineGraph1.makeGraph(data, marker_settings, function(dayIdFromGraph) {
        app.ports.getDayIdFromGraph.send(dayIdFromGraph);
    });

    plotlyBarGraph1.makeGraph(data, marker_settings, function(dayIdFromGraph) {
        app.ports.getDayIdFromGraph.send(dayIdFromGraph);
    });
}


app.ports.sendDayIdFromCardForest.subscribe(function(dayIdFromCardForest){
    data[1] = dayIdFromCardForest;

    requestAnimationFrame(function() {
        plot(data);
    });
});


app.ports.sendDataToGraphs.subscribe(function(dataGraph) {
    data[0] = dataGraph;

    requestAnimationFrame(function() {
        plot(data);
    });
});


// RxJS approach
// var Rx = require('../../node_modules/rxjs/Rx');
// require('../../node_modules/rxjs/add/operator/startWith');
// require('../../node_modules/rxjs/operator/startWith');

// var data$ = Rx.Observable.create(function (observer) {
//     app.ports.sendDataToGraphs.subscribe(function(dataGraph) {
//        observer.next(dataGraph);
// 	});
// });

// data$
//     .switchMap(function(graph) {
// 	    return Rx.Observable.create(function (observer) {
//             app.ports.sendDayIdFromCardForest.subscribe(function(dayIdFromCardForest){
// 		       observer.next([graph, dayIdFromCardForest]);
// 	        }).startWith([graph, null]);
//         });
//     })
//     .subscribe(function(data) {
// 	    // console.log('damn ja> ', data);
// 	    requestAnimationFrame(function() {
//             plotlyLineGraph1.makeGraph(data, function(dayIdFromGraph) {
//                 app.ports.getDayIdFromGraph.send(dayIdFromGraph);
//             });
// 		});
//     });
