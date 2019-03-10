var tableData = data;
var tbody = d3.select("tbody");

// Populate full table
tableData.forEach((sighting) => {
    var row = tbody.append("tr");
    Object.entries(sighting).forEach(([key, value]) => {
      var cell = tbody.append("td");
      cell.text(value);

////////////////

// filter table by date 
var filter = d3.select("#filter-btn");

filter.on("click", function() {
    d3.event.preventDefault();

    var inputElement = d3.select("#datetime");
    var inputValue = inputElement.property("value");
    var filteredData = tableData.filter(date => date.datetime === inputValue);
    tbody.selectAll('*').remove(); // refresh page to return full table

    filteredData.forEach((filter_sighting) => {
      var row = tbody.append("tr");
      Object.entries(filter_sighting).forEach(([key, value]) => {
        var cell = tbody.append("td")
        cell.text(value);
      
        });
      });
    });
  });
});
