package com.dev801.xplaneinfo;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Holder {

    private static final Logger LOGGER = LoggerFactory.getLogger(Holder.class);

    private static Map<Integer, List<Float>> blork;

    public static Map<Integer, List<Float>> getBlork() {
        return blork;
    }

    public static void setBlork(Map<Integer, List<Float>> blork) {
        Holder.blork = blork;
    }
}
