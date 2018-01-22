package fr.utt.if26.projetif26;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;

public class AccueilActivity extends AppCompatActivity implements View.OnClickListener {

    private Button bBiceps, btriceps, bBack, bLeg, bAbs, bChest, bShoulder;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_accueil);
        bBiceps = (Button) findViewById(R.id.bBiceps);
        btriceps = (Button) findViewById(R.id.bTriceps);
        bBack = (Button) findViewById(R.id.bBack);
        bLeg = (Button) findViewById(R.id.bLeg);
        bAbs = (Button) findViewById(R.id.abs);
        bChest = (Button) findViewById(R.id.bChest);
        bShoulder = (Button) findViewById(R.id.bShoulder);

        bBiceps.setOnClickListener(this);
        bShoulder.setOnClickListener(this);
        btriceps.setOnClickListener(this);
        bBack.setOnClickListener(this);
        bLeg.setOnClickListener(this);
        bAbs.setOnClickListener(this);
        bChest.setOnClickListener(this);

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.accueil_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_guide:

                return true;
            case R.id.menu_information:
                Intent i = getIntent();
                String s = i.getStringExtra("username");
                /*Intent intent = new Intent(this, InformationActivity.class);
                intent.putExtra("username", s);
                startActivity(intent);*/
                return true;
            case R.id.menu_exit:
                //  android.os.kill.process.killprocess(android.os.myPid());
                //System.exit(1);
                finish();
                return true;
            default:
                return super.onOptionsItemSelected(item);

        }
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.bBiceps:
                startActivity(new Intent(this, BicepsActivity.class));
                break;
            case R.id.bShoulder:
                startActivity(new Intent(this, ShoulderActivity.class));
                break;
            case R.id.abs:
                startActivity(new Intent(this, AbsActivity.class));
                break;
            case R.id.bLeg:
                startActivity(new Intent(this, LegActivity.class));
                break;
            case R.id.bChest:
                startActivity(new Intent(this, ChestActivity.class));
                break;
            case R.id.bTriceps:
                startActivity(new Intent(this, TricepsActivity.class));
                break;
            case R.id.bBack:
                startActivity(new Intent(this, BackActivity.class));
                break;
        }

    }
}
