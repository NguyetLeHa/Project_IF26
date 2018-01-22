package fr.utt.if26.projetif26;

import android.content.ContentValues;
import android.content.Intent;
import android.database.sqlite.SQLiteDatabase;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Toast;


public class FormulaireActivity extends AppCompatActivity implements View.OnClickListener {

    EditText etName, etFirstname, etUsername, etPassword, etConfPassword;
    RadioGroup radioGroup;
    RadioButton radioButton;
    Button bSave;
    DBManager dbManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_formulaire);

        etName = (EditText) findViewById(R.id.etName);
        etFirstname = (EditText) findViewById(R.id.etFirstname);
        etUsername = (EditText) findViewById(R.id.etUsername);
        etPassword = (EditText) findViewById(R.id.etPassword);
        etConfPassword = (EditText) findViewById(R.id.etConfPassword);
        radioGroup = (RadioGroup) findViewById(R.id.rgroup);

        dbManager = new DBManager(this);

        bSave = (Button) findViewById(R.id.bSave);
        bSave.setOnClickListener(this);


    }

    @Override
    public void onClick(View v) {

        if (v.getId() == R.id.bSave) {

            String name = etName.getText().toString();
            String firstname = etFirstname.getText().toString();
            String sexe = rbclick(v);
            String username = etUsername.getText().toString();
            String password = etPassword.getText().toString();
            String confPassword = etConfPassword.getText().toString();

            if (!password.equals(confPassword)) {
                Toast toast = Toast.makeText(this, "Password don't match", Toast.LENGTH_SHORT);
                toast.show();
            } else {
                dbManager.insertUser(name, firstname, sexe, username, password);
                dbManager.close();
                startActivity(new Intent(this, LoginActivity.class));
                Toast toast = Toast.makeText(this, "Register Success", Toast.LENGTH_SHORT);
                toast.show();
            }

        }
    }

    //Récupération du sexe dans le formulaire
    public String rbclick(View view) {
        int rbid = radioGroup.getCheckedRadioButtonId();
        radioButton = (RadioButton) findViewById(rbid);
        return radioButton.getText().toString();
    }


}
