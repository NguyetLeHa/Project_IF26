package fr.utt.if26.projetif26;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ImageView;

public class FullShoulderActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_full_shoulder);
        Intent intent = getIntent();
        ImageView imageView = (ImageView) findViewById(R.id.imageViewBiceps);
        int position = intent.getExtras().getInt("id");
        ShoulderAdapter shoulderAdapter = new ShoulderAdapter(this);
        imageView.setImageResource(shoulderAdapter.images[position]);
    }
}
