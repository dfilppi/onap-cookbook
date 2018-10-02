import org.openecomp.mso.utils.CryptoUtils;

public class Encrypt{

  public static void main(String[] args)throws Exception{

    if (args.length == 0 ){
       System.out.println("usage: encrypt <string>");
    }

    String arg = args[0];

    System.out.println(CryptoUtils.encrypt(arg, "aa3871669d893c7fb8abbcda31b88b4f"));
   }

}
