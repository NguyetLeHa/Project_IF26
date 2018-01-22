package fr.utt.if26.projetif26;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ImageView;

public class FullAbsActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_full_abs);
        Intent intent = getIntent();
        ImageView imageView = (ImageView) findViewById(R.id.imageViewBiceps);
        int position = intent.getExtras().getInt("id");
        ABSAdapter absAdapter = new ABSAdapter(this);
        imageView.setImageResource(absAdapter.images[position]);
    }
}
