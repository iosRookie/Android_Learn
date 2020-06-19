package de.mintware.barcode_scan;

import android.content.Context;
import android.content.res.Configuration;
import android.graphics.Canvas;
import android.graphics.CornerPathEffect;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Point;
import android.graphics.Rect;
import android.graphics.Shader;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.view.View;

import me.dm7.barcodescanner.core.DisplayUtils;
import me.dm7.barcodescanner.core.IViewFinder;


public class CustomViewFinderView extends View implements IViewFinder {
    private Rect mFramingRect;

    private static final float PORTRAIT_WIDTH_RATIO = 5f / 8;
    private static final float PORTRAIT_WIDTH_HEIGHT_RATIO = 0.75f;

    private static final float LANDSCAPE_HEIGHT_RATIO = 5f / 8;
    private static final float LANDSCAPE_WIDTH_HEIGHT_RATIO = 1.4f;
    private static final int MIN_DIMENSION_DIFF = 50;

    private static final float DEFAULT_SQUARE_DIMENSION_RATIO = 5f / 8;

    private final int mDefaultLaserColor = getResources().getColor(R.color.viewfinder_laser);
    private final int mDefaultMaskColor = getResources().getColor(R.color.viewfinder_mask);
    private final int mDefaultBorderColor = getResources().getColor(R.color.theme_blue);
    //    private final int mDefaultBorderStrokeWidth = getResources().getInteger(R.integer.viewfinder_border_width);
    private final int mDefaultBorderStrokeWidth = 12;
    private final int mDefaultBorderLineLength = getResources().getInteger(R.integer.viewfinder_border_length);

    protected Paint mLaserPaint;
    protected Paint mFinderMaskPaint;
    protected Paint mBorderPaint;
    protected int mBorderLineLength;
    protected boolean mSquareViewFinder = true;
    private boolean mIsLaserEnabled;
    private float mBordersAlpha;
    private int mViewFinderOffset = 0;

    private Paint scanLinePaint;
    private LinearGradient linearGradient;
    private int scanLinePosition;
    private float scanLineWidth = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, 5f, getResources().getDisplayMetrics());
    private float scanLineMoveOffset = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, 4f, getResources().getDisplayMetrics());
    private float[] scanLineColorPositions = new float[]{0.1f, 0.5f, 0.9f};
    private int scanLineCenterColor = getContext().getResources().getColor(R.color.theme_blue);
    private int scanLineEdgeColor = getContext().getResources().getColor(android.R.color.transparent);
    private int[] scanLineColors = new int[]{scanLineEdgeColor, scanLineCenterColor, scanLineEdgeColor};
    private static final long RE_DRAW_INTERVAL = 12L;


    public CustomViewFinderView(Context context) {
        this(context, null);
    }

    public CustomViewFinderView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        init();
    }


    private void init() {
        //set up laser paint
        mLaserPaint = new Paint();
        mLaserPaint.setColor(mDefaultLaserColor);
        mLaserPaint.setStyle(Paint.Style.FILL);

        //finder mask paint
        mFinderMaskPaint = new Paint();
        mFinderMaskPaint.setColor(mDefaultMaskColor);

        //border paint
        mBorderPaint = new Paint();
        mBorderPaint.setColor(mDefaultBorderColor);
        mBorderPaint.setStyle(Paint.Style.STROKE);
        mBorderPaint.setStrokeWidth(mDefaultBorderStrokeWidth);
        mBorderPaint.setAntiAlias(true);

        scanLinePaint = new Paint();
        scanLinePaint.setStyle(Paint.Style.FILL);
        scanLinePaint.setAntiAlias(true);

        mBorderLineLength = mDefaultBorderLineLength;
    }

    @Override
    public void setLaserColor(int laserColor) {
        mLaserPaint.setColor(laserColor);
    }

    @Override
    public void setMaskColor(int maskColor) {
        mFinderMaskPaint.setColor(maskColor);
    }

    @Override
    public void setBorderColor(int borderColor) {
        mBorderPaint.setColor(borderColor);
    }

    @Override
    public void setBorderStrokeWidth(int borderStrokeWidth) {
        mBorderPaint.setStrokeWidth(borderStrokeWidth);
    }

    @Override
    public void setBorderLineLength(int borderLineLength) {
        mBorderLineLength = borderLineLength;
    }

    @Override
    public void setLaserEnabled(boolean isLaserEnabled) {
        mIsLaserEnabled = isLaserEnabled;
    }

    @Override
    public void setBorderCornerRounded(boolean isBorderCornersRounded) {
        if (isBorderCornersRounded) {
            mBorderPaint.setStrokeJoin(Paint.Join.ROUND);
        } else {
            mBorderPaint.setStrokeJoin(Paint.Join.BEVEL);
        }
    }

    @Override
    public void setBorderAlpha(float alpha) {
        int colorAlpha = (int) (255 * alpha);
        mBordersAlpha = alpha;
        mBorderPaint.setAlpha(colorAlpha);
    }

    @Override
    public void setBorderCornerRadius(int borderCornersRadius) {
        mBorderPaint.setPathEffect(new CornerPathEffect(borderCornersRadius));
    }

    @Override
    public void setViewFinderOffset(int offset) {
        mViewFinderOffset = offset;
    }

    // TODO: Need a better way to configure this. Revisit when working on 2.0
    @Override
    public void setSquareViewFinder(boolean set) {
        mSquareViewFinder = set;
    }

    public void setupViewFinder() {
        updateFramingRect();
        invalidate();
    }

    public Rect getFramingRect() {
        return mFramingRect;
    }

    @Override
    public void onDraw(Canvas canvas) {
        Rect framingRect = getFramingRect();
        if (framingRect == null) {
            return;
        }
        drawViewFinderMask(canvas);
        drawViewFinderBorder(canvas);
        drawScanLine(canvas);
        postInvalidateDelayed(
                RE_DRAW_INTERVAL,
                framingRect.left,
                framingRect.top,
                framingRect.right,
                framingRect.bottom
        );
    }

    public void drawViewFinderMask(Canvas canvas) {
        Rect framingRect = getFramingRect();
        int width = canvas.getWidth();
        int height = canvas.getHeight();

        canvas.drawRect(0, 0, width, framingRect.top, mFinderMaskPaint);
        canvas.drawRect(0, framingRect.top, framingRect.left, framingRect.bottom, mFinderMaskPaint);
        canvas.drawRect(framingRect.right, framingRect.top, width, framingRect.bottom, mFinderMaskPaint);
        canvas.drawRect(0, framingRect.bottom, width, height, mFinderMaskPaint);
    }

    public void drawViewFinderBorder(Canvas canvas) {
        Rect framingRect = getFramingRect();
        int offset = mDefaultBorderStrokeWidth / 2;

        // Top-left corner
        Path path = new Path();
        path.moveTo(framingRect.left + offset, framingRect.top + mBorderLineLength);
        path.lineTo(framingRect.left + offset, framingRect.top + offset);
        path.lineTo(framingRect.left + mBorderLineLength, framingRect.top + offset);
        canvas.drawPath(path, mBorderPaint);

        // Top-right corner
        path.moveTo(framingRect.right - offset, framingRect.top + mBorderLineLength);
        path.lineTo(framingRect.right - offset, framingRect.top + offset);
        path.lineTo(framingRect.right - mBorderLineLength, framingRect.top + offset);
        canvas.drawPath(path, mBorderPaint);

        // Bottom-right corner
        path.moveTo(framingRect.right - offset, framingRect.bottom - mBorderLineLength);
        path.lineTo(framingRect.right - offset, framingRect.bottom - offset);
        path.lineTo(framingRect.right - mBorderLineLength, framingRect.bottom - offset);
        canvas.drawPath(path, mBorderPaint);

        // Bottom-left corner
        path.moveTo(framingRect.left + offset, framingRect.bottom - mBorderLineLength);
        path.lineTo(framingRect.left + offset, framingRect.bottom - offset);
        path.lineTo(framingRect.left + mBorderLineLength, framingRect.bottom - offset);
        canvas.drawPath(path, mBorderPaint);
    }


    @Override
    protected void onSizeChanged(int xNew, int yNew, int xOld, int yOld) {
        updateFramingRect();
    }

    public synchronized void updateFramingRect() {
        Point viewResolution = new Point(getWidth(), getHeight());
        int width;
        int height;
        int orientation = DisplayUtils.getScreenOrientation(getContext());

        if (mSquareViewFinder) {
            if (orientation != Configuration.ORIENTATION_PORTRAIT) {
                height = (int) (getHeight() * DEFAULT_SQUARE_DIMENSION_RATIO);
                width = height;
            } else {
                width = (int) (getWidth() * DEFAULT_SQUARE_DIMENSION_RATIO);
                height = width;
            }
        } else {
            if (orientation != Configuration.ORIENTATION_PORTRAIT) {
                height = (int) (getHeight() * LANDSCAPE_HEIGHT_RATIO);
                width = (int) (LANDSCAPE_WIDTH_HEIGHT_RATIO * height);
            } else {
                width = (int) (getWidth() * PORTRAIT_WIDTH_RATIO);
                height = (int) (PORTRAIT_WIDTH_HEIGHT_RATIO * width);
            }
        }

        if (width > getWidth()) {
            width = getWidth() - MIN_DIMENSION_DIFF;
        }

        if (height > getHeight()) {
            height = getHeight() - MIN_DIMENSION_DIFF;
        }

        int leftOffset = (viewResolution.x - width) / 2;
        int topOffset = (viewResolution.y - height) / 2;
        mFramingRect = new Rect(leftOffset + mViewFinderOffset, topOffset + mViewFinderOffset, leftOffset + width - mViewFinderOffset, topOffset + height - mViewFinderOffset);
    }


    public void drawScanLine(Canvas canvas) {
        Rect framingRect = getFramingRect();

        if (scanLinePosition <= 0) {
            scanLineMoveOffset = 4;
        } else if (scanLinePosition >= framingRect.height() - scanLineWidth) {
            scanLineMoveOffset = -4;
        }

        scanLinePosition += scanLineMoveOffset;

        if (scanLinePosition <= 0) {
            scanLinePosition = 0;
        } else if (scanLinePosition >= framingRect.height() - scanLineWidth) {
            scanLinePosition = (int) (framingRect.height() - scanLineWidth);
        }


        linearGradient = new LinearGradient(
                framingRect.left,
                (framingRect.top + scanLinePosition),
                framingRect.right,
                (framingRect.top + scanLinePosition + scanLineWidth),
                scanLineColors,
                scanLineColorPositions,
                Shader.TileMode.CLAMP
        );

        scanLinePaint.setShader(linearGradient);
        canvas.drawRect(
                framingRect.left,
                (framingRect.top + scanLinePosition),
                framingRect.right,
                framingRect.top + scanLinePosition + scanLineWidth, scanLinePaint
        );
    }
}
