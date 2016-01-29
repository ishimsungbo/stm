package com.jui.stm.test;

import javax.swing.*;
import java.awt.*;

/**
 * Created by sungbo on 2015-10-29.
 */
public class Applet extends JApplet {

    public void init(){
        Container container = getContentPane();
        container.add(new JLabel("Hello, Java",SwingConstants.CENTER));
    }

}
