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

public class LegAdapter extends BaseAdapter {
    private Context context;
    public Integer[] images = {
            R.drawable.l, R.drawable.l1, R.drawable.l2, R.drawable.l3, R.drawable.l4, R.drawable.l5,
            R.drawable.l6, R.drawable.l7
    };

    public LegAdapter(Context c) {

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
