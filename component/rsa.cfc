<!---
	rsa.cfc (https://github.com/FreddyF1977/cfml-rsa/) - Fork
	Component for asymmetric key cryptograph using java security, it has these methods:
	-	 create_key_pair: creates a RSA key-pair, returns a struct with public and private key
	-	 encrypt_string:  encrypts a text-string with public or private key (for private key provide parameter key_type='private') returns base64 encoded string
	-	 decrypt_string:  decrypts a base64 string with public or private key (for public key provide parameter key_type='public') returns plain text-string

	Can be used with BouncyCastleProvider e.g. http://www.bouncycastle.org/download/bcprov-jdk15on-161.jar
	For BouncyCastle jar you can use JavaLoader (https://github.com/markmandel/JavaLoader)

	@OriginalAuthor	Cornelius Rittner
	@Website http://ggfx.org
	@Date 25.07.2013

	@ModernizedBy Frédéric Fortier
	@Date 16.02.2019
--->

component displayname="RSA" output="false" hint="Creates KeyPairs, encrypts and decrypts strings" {
	
	/**
	* @hint Constructor
	* @javaLoader JavaLoader object or path to component with dot-notation e.g. javaloader.javaloader
	* @bouncyCastle_Path full directory path and filename to jar 
	*/	
	public rsa function init(javaloader javaLoader, string bouncyCastle_Path = 'org.bouncycastle.jce.provider.BouncyCastleProvider') {
		variables.bouncyCastle = createObject('java', 'org.bouncycastle.jce.provider.BouncyCastleProvider').init();
	
		return this;
	}

	/**
	* @hint Uses KeyPairGenerator to create object
	* @key_size 1024, 2048, 4096.. the larger the longer the request takes
	* @output_type object, binary or string 
	*/	
	public struct function create_key_pair(numeric key_size = 512, string output_type = 'string') {
		var local = {};
		var obj_kpg = createObject('java','java.security.KeyPairGenerator');

		local.out = {};

			/* Get an instance of the provider for the RSA algorithm. */
			if (variables.keyExists('bouncyCastle') && isObject(variables.bouncyCastle)) {
				local.rsa = obj_kpg.getInstance("RSA",variables.bouncyCastle);
			} else {
				local.rsa = obj_kpg.getInstance("RSA");
			}

			/* Get an instance of secureRandom, we'll need this to initialize the key generator */
			local.sr = createObject('java', 'java.security.SecureRandom').init();

			/* Initialize the generator by passing in the key size, and a strong pseudo-random number generator */
			local.rsa.initialize(arguments.key_size, local.sr);

			/* This will create both one public and one private key */
			local.kp = local.rsa.generateKeyPair();

			/* Get the two keys */
			local.out.private_key = local.kp.getPrivate();
			local.out.public_key = local.kp.getPublic();

			if (arguments.output_type != "object") {
				local.out.private_key = local.out.private_key.getEncoded();
				local.out.public_key = local.out.public_key.getEncoded();

				/* Retreive a Base64 encoded version of the key. Can be stored in file or database */
				if (arguments.output_type == "string") {
					local.out.private_key = toBase64(local.out.private_key);
					local.out.public_key = toBase64(local.out.public_key);
				}
			}

		return local.out;
	}

	/**
	* @hint encrypts a text-string with RSA to a base64 encoded string
	* @text plain input text-string
	* @key the key 
	* @key_type public or private 
	*/	
	public string function encrypt_string(required string text, required string key, string key_type = 'public') {
		var local = {};
		/* Create a Java Cipher object and get a mode */
		var cipher = createObject('java', 'javax.crypto.Cipher').getInstance("RSA");

			if (!isObject(arguments.key)) {
				arguments.key = create_key_object_helper(arguments.key,arguments.key_type);
			}

			/* Initialize the Cipher with the mode and the key */
			cipher.init(cipher.ENCRYPT_MODE, arguments.key);

			/* Perform encryption of bytes, returns binary */
			local.encrypted = cipher.doFinal(arguments.text.getBytes("UTF-8"));

		/* Convert binary to Base64 encoded string */
		return toBase64(local.encrypted);
	}

	/**
	* @hint decrypts a base64 encoded string with RSA to its value
	* @text the encrypted value as Base64 encoded string
	* @key the key 
	* @key_type public or private 
	*/	
	public string function decrypt_string(required string text, required string key, string key_type = 'public') {

	}

	/**
	* @hint creates an object out of a [base64 encoded] binary key
	* @key the key 
	* @type public or private 
	*/	
	public string function create_key_object_helper(required any key, required string type) {

	}

}