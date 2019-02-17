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
		return this;
	}

	/**
	* @hint Uses KeyPairGenerator to create object
	* @key_size 1024, 2048, 4096.. the larger the longer the request takes
	* @output_type object, binary or string 
	*/	
	public struct function create_key_pair(numeric key_size = 512, string output_type = 'string') {
		
	}

	/**
	* @hint encrypts a text-string with RSA to a base64 encoded string
	* @text plain input text-string
	* @key the key 
	* @key_type public or private 
	*/	
	public string function encrypt_string(required string text, required string key, string key_type = 'public') {
		
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