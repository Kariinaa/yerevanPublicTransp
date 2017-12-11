package com.aua.entity;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class Parser {
    public static void main(String[] args) {
        try (BufferedReader br = new BufferedReader(new FileReader("fileanun.csv"))) {
            String line;
            while ((line = br.readLine()) != null) {
                //anel baner
                Files.write(Paths.get("fileanun.csv"), line.getBytes());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
