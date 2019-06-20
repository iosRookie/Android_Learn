package com.example.myapplication;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.lang.reflect.Array;

public class MainActivity extends AppCompatActivity implements AdapterView.OnItemClickListener {
    public static String MAIN_ACTIVITY_LOG = "activity_life_cycle";

    private String[] titles = {"ListView","RecylerView"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ListView mainList = findViewById(R.id.main_list_view);
        ArrayAdapter arrayAdapter = new ArrayAdapter(this, android.R.layout.simple_expandable_list_item_1, titles);
        mainList.setAdapter(arrayAdapter);
        mainList.setOnItemClickListener(this);

        Log.d(MAIN_ACTIVITY_LOG, "onCreate: ");
    }

    @Override
    protected void onStart() {
        super.onStart();

        Log.d(MAIN_ACTIVITY_LOG, "onStart: ");
    }

    @Override
    protected void onPause() {
        super.onPause();

        Log.d(MAIN_ACTIVITY_LOG, "onPause: ");
    }

    @Override
    protected void onResume() {
        super.onResume();

        Log.d(MAIN_ACTIVITY_LOG, "onResume: ");
    }

    @Override
    protected void onRestart() {
        super.onRestart();

        Log.d(MAIN_ACTIVITY_LOG, "onRestart: ");
    }

    @Override
    protected void onStop() {
        super.onStop();

        Log.d(MAIN_ACTIVITY_LOG, "onStop: ");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        Log.d(MAIN_ACTIVITY_LOG, "onDestroy: ");
    }


    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        if (Array.get(titles, position).equals("ListView")) {
            Intent intent = new Intent(this, ListViewLearn.class);
            startActivity(intent);
        }

        if (Array.get(titles, position).equals("RecylerView")) {

        }
    }
}
