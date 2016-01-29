package com.jui.stm.test;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.web.HTMLEditor;
import javafx.stage.Stage;

/**
 * Created by sungbo on 2015-11-04.
 */
public class FxTest extends Application  {

        @Override
        public void start(Stage stage) {
            HTMLEditor htmlEditor = new HTMLEditor();
            htmlEditor.setPrefHeight(245);
            Scene scene = new Scene(htmlEditor);
            stage.setScene(scene);
            stage.show();
        }
        public static void main(String[] args) {
            launch(args);

    }
}
