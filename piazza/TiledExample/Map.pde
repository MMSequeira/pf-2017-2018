class Map {
  private PVector position;
  private Ptmx map;
  private ArrayList<Rectangle> objects;

  Map(PApplet applet, String mapFileName, PVector position) {
    map = new Ptmx(applet, mapFileName);
    map.setDrawMode(CORNER);
    map.setPositionMode("CANVAS");
    this.position = position.copy();
    objects = new ArrayList<Rectangle>();
    for (StringDict objectDict : map.getObjects(1)) {
      float x = position.x + parseFloat(objectDict.get("x"));
      float y = position.y + parseFloat(objectDict.get("y"));
      float w = parseFloat(objectDict.get("width"));
      float h = parseFloat(objectDict.get("height"));
      objects.add(new Rectangle(x, y, w, h));
    }
  }

  void update() {
  }
  
  void display() {
    map.draw(0, PVector.mult(position, -1));
  }
  
  ArrayList<Rectangle> objects() {
    return new ArrayList<Rectangle>(objects);
  }
  
  color backgroundColor() {
    return map.getBackgroundColor();
  }
}