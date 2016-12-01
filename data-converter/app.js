"use strict";
var fs = require('fs');
var Converter = require("csvtojson").Converter;
var converter = new Converter({});

converter.fromFile("recipes.csv",function(err,result){
    if (err) {
        console.log("error: " + err); 
    } else {
        var recipes = {"recipes": result};
        var json = JSON.stringify(recipes, null, 4);

        //write json to file
        fs.writeFile("recipes.json", json, function(err) {
            if(err) {
                return console.log(err);
            }

            console.log("Recipes saved to file!");
        }); 
    }
});