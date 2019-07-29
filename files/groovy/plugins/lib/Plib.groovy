import jenkins.*
import jenkins.model.*

///////////////////////////////////////////////////
//common methods useable in multiple scripts
///////////////////////////////////////////////////
class Plib {

  class MissingRequiredPlugin extends Exception {}

  void requirePlugin(String plugin) {
    def j = Jenkins.getInstance()

    if (! j.getPlugin(plugin)) {
      throw new MissingRequiredPlugin(plugin)
    }
  }

  ///////////////////////////////////////////////////
  //  returns null for null like strings
  ///////////////////////////////////////////////////

  String nullStringCheck(String v) {

    switch (v) {
      case '':
      case 'null':
      case 'undef':
      return null
      break
      default:
      return v
      break
    }
  }

  ///////////////////////////////////////////////////
  // Turns a maplike string to a real map (key:value key:value ....)
  ///////////////////////////////////////////////////

  LinkedHashMap argsToMap(String... args) {
    def res = [:]
    args.each() {
      def pair = it.split(':|=',2)
      if ( pair.size() == 2 ) {
        res << [(pair.first()): pair.last()]
      }
    }
    return res
  }

  ///////////////////////////////////////////////////
  // remove all elements having a value of null from a map
  ///////////////////////////////////////////////////

  LinkedHashMap mapRemoveAllNull(LinkedHashMap map) {
    def res = [:]
    map.each() { k,v ->
      if (v || v.getClass() == Boolean ) {
        res.put(k,v)
      }
    }
    return res
  }

  ///////////////////////////////////////////////////
  // Print a map
  ///////////////////////////////////////////////////

  void printMap(LinkedHashMap map) {
    out.println(map.toMapString()?.replaceAll(/, /,/ /))
  }
  
  ///////////////////////////////////////////////////
  // decode a base64 encoded string
  ///////////////////////////////////////////////////

  String decodeKey(String key) {
    byte[] decoded=key.decodeBase64()
    return new String(decoded)
  }

  ///////////////////////////////////////////////////
  // encode a string using base64
  ///////////////////////////////////////////////////

  String encodeKey(String key) {
    return key.bytes.encodeBase64().toString()
  }

  ///////////////////////////////////////////////////
  // debug funtion to print the methods of an object
  ///////////////////////////////////////////////////

  void printAllMethods( obj ){
    if( !obj ){
      out.println( "Object is null\r\n" );
      return;
    }
    if( !obj.metaClass && obj.getClass() ){
      printAllMethods( obj.getClass() );
      return;
    }
    def str = "class ${obj.getClass().name} functions:\r\n";
    obj.metaClass.methods.name.unique().each{
      str += it+"(); ";
    }
    out.println "${str}\r\n";
  }

  //////////////////////////////////////////////////////
  // debug function to print all properties of an object
  //////////////////////////////////////////////////////

  void printAllProperties( obj ){
    if( !obj ){
      out.println( "Object is null\r\n" );
      return;
    }
    def filtered = ['class', 'active']

    out.println obj.properties
    .sort{it.key}
    .collect{it}
    .findAll{!filtered.contains(it.key)}
    .join('\n')
  }
} // class Plib
