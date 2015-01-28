static final int precision = 100; // gradations per degree, adjust to suit
static final int modulus = 360*precision;
static final float[] sin = new float[modulus]; // lookup table
static { 
    // a static initializer fills the table
    // in this implementation, units are in degrees
    for (int i = 0; i<sin.length; i++) {
        sin[i]=(float)Math.sin((i*Math.PI)/(precision*180));
    }
}
// Private function for table lookup
private static float sinLookup(int a) {
    return a>=0 ? sin[a%(modulus)] : -sin[-a%(modulus)];
}
public static float fast_sin(float a) { 
    return sinLookup((int)(a * 57.2957795 * precision + 0.5f));
}
public static float fast_cos(float a) {
    return sinLookup((int)((a*57.2957795+90f) * precision + 0.5f));
}
