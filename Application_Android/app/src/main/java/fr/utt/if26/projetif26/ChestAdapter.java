package fr.utt.if26.projetif26;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;

/**
 * Created by Ghost on 02/01/2018.
 */

public class ChestAdapter extends BaseAdapter {
    private Context context;
    public Integer[] images = {
            R.drawable.c, R.drawable.c1, R.drawable.c2, R.drawable.c3, R.drawable.c4, R.drawable.c5,
            R.drawable.c6
    };

    public ChestAdapter(Context c) {

        context = c;
    }


    @Override
    public int getCount() {
        return images.length;
    }

    @Override
    public Object getItem(int position) {
        return images[position];
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ImageView imageView = new ImageView(context);
        imageView.setImageResource(images[position]);
        imageView.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
        imageView.setLayoutParams(new GridView.LayoutParams(240, 240));
        return imageView;
    }
}
