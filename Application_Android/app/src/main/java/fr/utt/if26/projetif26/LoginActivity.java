package fr.utt.if26.projetif26;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class LoginActivity extends AppCompatActivity implements View.OnClickListener {

    Button bLogin;
    EditText etUsername, etPassword;
    TextView tvregister;
    DBManager dbManager = new DBManager(this);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        bLogin = (Button) findViewById(R.id.bLogin);
        etUsername = (EditText) findViewById(R.id.etUsername);
        etPassword = (EditText) findViewById(R.id.etPassword);
        tvregister = (TextView) findViewById(R.id.tvregister);

        tvregister.setOnClickListener(this);
        bLogin.setOnClickListener(this);

    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.bLogin:
                String username = etUsername.getText().toString();
                String password = etPassword.getText().toString();
                String pass = dbManager.checkAuth(username);
                if (password.equals(pass)) {
                    //Toast.makeText(this,"Login and Password correct !!!",Toast.LENGTH_LONG).show();
                    Intent intent = new Intent(this, AccueilActivity.class);
                    intent.putExtra("username", username);
                    startActivity(intent);
                } else
                    Toast.makeText(this, "Login or Password incorrect !!!", Toast.LENGTH_LONG).show();

                break;
            case R.id.tvregister:
                startActivity(new Intent(this, FormulaireActivity.class));
                break;
        }
    }
}
