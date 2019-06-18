package com.gps.service;

import java.util.HashMap;
import java.util.Map;


public class CreditCode {

        static String creditCode = "S132058571785883X1";// ���� 91350100M000100Y43
        static String isCreditCode = "true";
        static String error_CreditCode = "������ô�������";
        static String error_CreditCode_min = "������ô��벻��18λ����˶Ժ����䣡";
        static String error_CreditCode_max = "������ô������18λ����˶Ժ����䣡";
        static String error_CreditCode_empty ="������ô��벻��Ϊ�գ�";
        private static Map<String,Integer> datas = null;
        private static char[] pre17s;
        static int[] power = {1,3,9,27,19,26,16,17,20,29,25,13,8,24,10,30,28};
        // ���ͳһ���ô��벻����I��O��S��V��Z�� ����ĸ
        static char[] code = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','T','U','W','X','Y'};
        public  static  void main(String[] args){
            String temp = creditCode;
            initDatas(code.length);
            pre17(temp);
            isCreditCode(temp);
        }

        /**
         * �ж��Ƿ���һ����Ч��������ô���
         * @param creditCode
         * @return
         */
        static String isCreditCode(String creditCode){
            if("".equals(creditCode)||" ".equals(creditCode)){
                System.out.println(error_CreditCode_empty);
                return error_CreditCode_empty;
            }else if(creditCode.length()<18){
                System.out.println(error_CreditCode_min);
                return  error_CreditCode_min;
            }else if(creditCode.length()>18){
                System.out.println(error_CreditCode_max);
                return  error_CreditCode_max;
            }else{
                int sum =  sum(pre17s);
                int temp = sum%31;
                temp = temp==0?31:temp;//  лл whhitli�İ���
                System.out.println(code[31-temp]+" "+(creditCode.substring(17,18).equals(code[31-temp]+"")?isCreditCode:error_CreditCode));
                return creditCode.substring(17,18).equals(code[31-temp]+"")?isCreditCode:error_CreditCode;
            }
        }

        /**
         * @param chars
         * @return
         */
        private static int sum(char[] chars){
            int sum = 0;
            for(int i=0;i<chars.length;i++){
                System.out.println(chars[i]);
                int code = datas.get(chars[i]+"");
                sum+=power[i]*code;
            }
            return sum;
        }

        /**
         * ��ȡǰ17λ�ַ�
         * @param creditCode
         */
        static  void  pre17(String creditCode){
            String pre17 = creditCode.substring(0,17);
            pre17s = pre17.toCharArray();
        }

        /**
         * ��ʼ������
         * @param count
         */
        static void  initDatas(int count){
            datas = new HashMap<String,Integer>();
            for(int i=0;i<code.length;i++){
                datas.put(code[i]+"",i);
            }
        }
}
