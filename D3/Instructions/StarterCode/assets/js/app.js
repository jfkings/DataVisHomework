
// @TODO: YOUR CODE HERE!

var svgWidth = 960;
var svgHeight = 500;

var margin = {
    top:20,
    right:40,
    bottom:80,
    left: 50
};

var chartWidth = svgWidth - margin.left - margin.right;
var chartHeight = svgHeight - margin.top - margin.bottom;

var svg = d3.select("#scatter")
    .append("svg")
    .attr("width", svgWidth)
    .attr("height", svgHeight);

var chartGroup = svg.append("g")
    .attr("transform",`translate(${margin.left},${margin.top})`);

d3.csv("assets/data/data.csv", function(err, data){
    if(err) throw err;
    data.forEach(function(record){
        record.poverty = +record.poverty;
        record.healthcare = +record.healthcare;
        record.obesity = +record.obesity;
    });
    
    var xLinearScale = d3.scaleLinear()
        .domain([d3.min(data, d=>d["poverty"]-1),
        d3.max(data,d=>d["poverty"])])
        .range([0,chartWidth]);

    var yLinearScale = d3.scaleLinear()
        .domain([d3.min(data, d=>d["healthcare"]-1),
            d3.max(data, d=>d["healthcare"])])
        .range([chartHeight,0]);

    var bottomAxis = d3.axisBottom(xLinearScale);
    var leftAxis = d3.axisLeft(yLinearScale);

    var xAxis = chartGroup.append("g")
    .classed("x-axis", true)
    .attr("transform", `translate(0, ${chartHeight})`)
    .call(bottomAxis);

    chartGroup.append("g")
    .call(leftAxis);

    var gdots =  chartGroup.selectAll("g.dot")
        .data(data)
        .enter()
        .append('g');

    gdots.append("circle")
        .attr("cx", d => xLinearScale(d["poverty"]))
        .attr("cy", d => yLinearScale(d["healthcare"]))
        .attr("r", d=>d.obesity / 2)
        .attr("fill", "blue")
        .attr("opacity", ".5");

    gdots.append("text").text(d=>d.abbr)
        .attr("x", d => xLinearScale(d.poverty)-4)
        .attr("y", d => yLinearScale(d.healthcare)+2)
        .style("font-size",".6em")
        .classed("fill-text", true);

  var labelsGroup = chartGroup.append("g")
    .attr("transform", `translate(${chartWidth / 2}, ${chartHeight + 20})`);

  var dataLabel = labelsGroup.append("text")
    .attr("x", 0)
    .attr("y", 20)
    .attr("value", "poverty")
    .classed("active", true)
    .text("Poverty");

    chartGroup.append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 0 - margin.left)
    .attr("x", 0 - (chartHeight / 2))
    .attr("dy", "1em")
    .classed("axis-text", true)
    .text("Healthcare");
});
