package com.ucloudlink.core_log;

/**
 * Author: 肖扬威
 * Date: 2020/3/3 15:19
 * Description:
 */
public class Rc4 {
    private static String skey = "ukelinkucservice";
    private static byte initLogKey[] = null;
    private static Object lock = new Object();

    private static byte[] rc4LogInit() {
        if (initLogKey == null) {
            synchronized (lock) {
                if (initLogKey == null) {
                    initLogKey = initKey(skey);
                }
            }
        }
        return initLogKey.clone();
    }

    //for log
    public static String encrypt(String data) {
        if (data == null) {
            return null;
        }
        return toHex(encry_RC4_byte_Log(data, skey));
    }

    private static String toHex(byte[] buffer) {
        StringBuffer sb = new StringBuffer(buffer.length * 2);
        for (int i = 0; i < buffer.length; i++) {
            sb.append(Character.forDigit((buffer[i] & 240) >> 4, 16));
            sb.append(Character.forDigit(buffer[i] & 15, 16));
        }
        return sb.toString();
    }

    private static byte[] initKey(String aKey) {
        byte[] b_key = aKey.getBytes();
        byte state[] = new byte[256];

        for (int i = 0; i < 256; i++) {
            state[i] = (byte) i;
        }
        int index1 = 0;
        int index2 = 0;
        if (b_key == null || b_key.length == 0) {
            return null;
        }
        for (int i = 0; i < 256; i++) {
            index2 = ((b_key[index1] & 0xff) + (state[i] & 0xff) + index2) & 0xff;
            byte tmp = state[i];
            state[i] = state[index2];
            state[index2] = tmp;
            index1 = (index1 + 1) % b_key.length;
        }
        return state;
    }


    private static byte[] RC4BaseLog(byte[] input, String mKkey) {
        int x = 0;
        int y = 0;
        int xorIndex;

        byte[] result = new byte[input.length];
        byte[] initLogKeyToUse = rc4LogInit();
        for (int i = 0; i < input.length; i++) {
            x = (x + 1) & 0xff;
            y = ((initLogKeyToUse[x] & 0xff) + y) & 0xff;
            byte tmp = initLogKeyToUse[x];
            initLogKeyToUse[x] = initLogKeyToUse[y];
            initLogKeyToUse[y] = tmp;
            xorIndex = ((initLogKeyToUse[x] & 0xff) + (initLogKeyToUse[y] & 0xff)) & 0xff;
            result[i] = (byte) (input[i] ^ initLogKeyToUse[xorIndex]);
        }
        return result;
    }

    public static byte[] encry_RC4_byte_Log(String data, String key) {
        if (data == null || key == null) {
            return null;
        }
        byte b_data[] = data.getBytes();
        return RC4BaseLog(b_data, key);
    }
}
