// ignore_for_file: sort_child_properties_last, prefer_const_constructors

// import 'package:buildwithinnovationassignment/apiservices/model.dart';
import 'package:buildwithinnovationassignment/apiservices/model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MyAlbum> album = [];

  Future<List<MyAlbum>> getdata() async {
    var response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        album.add(MyAlbum.fromJson(index));
      }
      return album;
    } else {
      return album;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: album.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Container(
                            //height: 400,
                            width: 300,
                            child: Container(
                              child: Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text("Id : ${album[index].id}"),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Image.network(
                                    album[index].image,
                                    height: 200,
                                  ),
                                  Text("Title : ${album[index].title}"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      "Price : ${album[index].price.toString()}"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      "Description : ${album[index].description}"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Category : ${album[index].category}"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Rating : ${album[index].rating}"),
                                ],
                              ),
                            ),
                            //height: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black26),
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
