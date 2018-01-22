package fr.utt.if26.projetif26;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

public class InformationActivity extends AppCompatActivity {

    TextView tvWlecome, tvInfoNom, tvInfoPrenom, tvInfoSexe, tvInfoUsername;
    DBManager dbManager;
    Users users;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_information);

        tvWlecome = (TextView) findViewById(R.id.tvWelcome);
        tvInfoNom = (TextView) findViewById(R.id.tvInfoNom);
        tvInfoPrenom = (TextView) findViewById(R.id.tvInfoPrenom);
        tvInfoSexe = (TextView) findViewById(R.id.tvInfoSexe);
        tvInfoUsername = (TextView) findViewById(R.id.tvInfoUsername);
        users = new Users();
        dbManager = new DBManager(this);

        Intent intent = getIntent();
        String USN = intent.getStringExtra("username");
        tvWlecome.setText("Welcome  " + USN);
        dbManager.getInformation(USN);
        tvInfoNom.setText("Name: "+users.getName().toString());
        tvInfoPrenom.setText("FirstName: "+users.getFirstname().toString());
        tvInfoSexe.setText("Sexe: "+users.getSexe().toString());


    }
}
