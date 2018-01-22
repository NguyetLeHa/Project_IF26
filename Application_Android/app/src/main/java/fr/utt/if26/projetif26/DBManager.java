package fr.utt.if26.projetif26;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

/**
 * Created by Ghost on 11/12/2017.
 */

public class DBManager extends SQLiteOpenHelper {

    public static final String DATABASE_NAME = "User.db";
    public static final int DATABASE_VERSION = 1;
    Users users;


    //Créeation de la table userTable
    private static final String sqlTable = "create table T_Users ("
            + " id integer primary key autoincrement, "
            + " name_ text not null, "
            + " firstname_ text not null, "
            + " sexe_ text not null, "
            + " username_ text not null, "
            + " password_ text not null);";

    public DBManager(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }


    @Override
    public void onCreate(SQLiteDatabase db) {

        db.execSQL(sqlTable);
        Log.i("DATABASE", "onCreate invoked");

    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

        db.execSQL("DROP TABLE IF EXISTS");
        this.onCreate(db);
        Log.i("DATABASE", "onUpgrade invoked");
    }

    public void insertUser(String name, String firstname, String sexe, String username, String password) {
        String sql = "insert into T_Users (name_,firstname_,sexe_,username_,password_) values ('"
                + name + "','" + firstname + "','" + sexe + "','" + username + "','" + password + "')";
        this.getWritableDatabase().execSQL(sql);
        Log.i("DATABASE", "insertUser invoked");

    }

    public String checkAuth(String username) {
        users = new Users();
        String sql = "select * from T_Users";
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery(sql, null);
        String USN, PSW = "not match";
        if (cursor.moveToFirst()) {
            do {
                USN = cursor.getString(4);
                if (USN.equals(username)) {
                    //users.setUsername(USN);
                    PSW = cursor.getString(5);
                    break;
                }

            } while (cursor.moveToNext());
        }

        return PSW;

    }

    public void getInformation(String username) {
        String sql = "select * from T_Users where username_='" + username + "'";
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery(sql, null);
        users = new Users();
        users.setName(cursor.getString(1));
        users.setFirstname(cursor.getString(2));
        users.setSexe(cursor.getString(3));
    }

}
