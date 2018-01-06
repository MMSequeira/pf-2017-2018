// Slightly modified version of Ptmx. See original code in:
//  https://github.com/linux-man/ptmx
//
// Beware! The modifications are incomplete. Ptmx avoids drawing out of screen
// tiles, and that part of the code was not updated. This means large maps will
// be clipped in weird places! Beware!

public class Ptmx {
  private float version;
  private String filename, orientation, renderorder, staggeraxis; //renderorder is not used. Always "right-down"
  private int camwidth, camheight, camleft, camtop, mapwidth, mapheight, tilewidth, tileheight, staggerindex, hexsidelength, backgroundcolor;
  private int drawmargin = 2;
  private int drawmode = 0; //0=CORNER, 3=CENTER
  private String positionmode = "CANVAS"; //"CANVAS" or "MAP"
  private Tile[] tile = new Tile[0];
  private Layer[] layer = new Layer[0];
  private Xmap map;

  abstract class Xmap {
    abstract PVector mapToCanvas(float nx, float ny);
    abstract PVector canvasToMap(float x, float y);
    abstract void drawTileLayer(PGraphics pg, int m);
  }

  private class OrthogonalMap extends Xmap {
    public PVector mapToCanvas(float nx, float ny) {
      float x = (nx + (float)0.5) * tilewidth;
      float y = (ny + (float)0.5) * tileheight;
      return new PVector(x, y);
    }
    public PVector canvasToMap(float x, float y) {
      float nx = x / tilewidth - (float)0.5;
      float ny = y / tileheight - (float)0.5;
      return new PVector(nx, ny);
    }
    public void drawTileLayer(PGraphics pg, int m) {
      int n;
      float x, y;
      PVector p;
      Tile tileN;
      Layer l = layer[m];
      int xstart = max(0, floor(canvasToMap(camleft, camtop).x - drawmargin));
      int xstop = min(mapwidth, ceil(canvasToMap(camleft + pg.width, camtop + pg.height).x + drawmargin));
      int ystart = max(0, floor(canvasToMap(camleft, camtop).y - drawmargin));
      int ystop = min(mapheight, ceil(canvasToMap(camleft + pg.width, camtop + pg.height).y + drawmargin));
      for (int ny = ystart; ny < ystop; ny++) for (int nx = xstart; nx < xstop; nx++) {
        n = l.data[nx + ny * mapwidth] - 1;
        if (n >= 0) {
          tileN = tile[n];
          p = mapToCam(nx, ny);
          x = p.x - tilewidth / 2 + tileN.offsetx + l.offsetx;
          y = p.y - tileheight / 2 + tileN.offsety + l.offsety + (tileheight - tileN.image.height);
          ;
          pg.image(tileN.image, x, y);
        }
      }
    }
  }

  private class IsometricMap extends Xmap {
    public PVector mapToCanvas(float nx, float ny) {
      float x = (mapwidth + mapheight) * tilewidth / 4 + (nx - ny) * tilewidth / 2;
      float y = (nx + ny + 1) * tileheight / 2;
      return new PVector(x, y);
    }
    public PVector canvasToMap(float x, float y) {
      float dif = ((float)mapwidth + mapheight) * tilewidth / 4;
      float nx = y / tileheight + ((x - dif) / tilewidth) - (float)0.5;
      float ny = y / tileheight - ((x - dif) / tilewidth) - (float)0.5;
      return new PVector(nx, ny);
    }
    public void drawTileLayer(PGraphics pg, int m) {
      int n;
      float x, y;
      PVector p;
      Tile tileN;
      Layer l = layer[m];
      int xstart = max(0, floor(canvasToMap(camleft, camtop).x - drawmargin));
      int xstop = min(mapwidth, ceil(canvasToMap(camleft + pg.width, camtop + pg.height).x + drawmargin));
      int ystart = max(0, floor(canvasToMap(camleft + pg.width, camtop).y - drawmargin));
      int ystop = min(mapheight, ceil(canvasToMap(camleft, camtop + pg.height).y + drawmargin));
      for (int ny = ystart; ny < ystop; ny++) for (int nx = xstart; nx < xstop; nx++) {
        n = l.data[nx + ny * mapwidth] - 1;
        if (n >= 0) {
          tileN = tile[n];
          p = mapToCam(nx, ny);
          x = p.x - tilewidth / 2 + tileN.offsetx + l.offsetx;
          y = p.y - tileheight / 2 + tileN.offsety + l.offsety + (tileheight - tileN.image.height);
          ;
          pg.image(tileN.image, x, y);
        }
      }
    }
  }

  private class StaggeredXMap extends Xmap {
    public PVector mapToCanvas(float nx, float ny) {
      float x = (nx * (hexsidelength + tilewidth) + tilewidth) / 2;
      float y = (ny + (float)0.5 + staggerindex / 2) * tileheight + (staggerindex * 2 - 1) * (abs(abs(nx) % 2 - 1) - 1) * (tileheight) / 2;
      return new PVector(x, y);
    }
    public PVector canvasToMap(float x, float y) {
      float ny;
      float nx = (x * 2 - tilewidth) / (hexsidelength + tilewidth);
      if (staggerindex == 0) ny = y / tileheight - 1 + (abs(abs(nx) % 2 - 1)) / 2;
      else ny = y / tileheight - (float)0.5 - (abs(abs(nx) % 2 - 1)) / 2;
      return new PVector(nx, ny);
    }
    public void drawTileLayer(PGraphics pg, int m) {
      int n;
      float x, y;
      PVector p;
      Tile tileN;
      Layer l = layer[m];
      int xstart = floor(canvasToMap(camleft, camtop).x - drawmargin);
      xstart = max(0, xstart - xstart % 2);
      int xstop = min(mapwidth, ceil(canvasToMap(camleft + pg.width, camtop + pg.height).x + drawmargin));
      int ystart = max(0, floor(canvasToMap(camleft, camtop).y - drawmargin));
      int ystop = min(mapheight, ceil(canvasToMap(camleft + pg.width, camtop + pg.height).y + drawmargin));
      for (int ny = ystart; ny < ystop; ny++) for (int nx = xstart; nx < xstop; nx++) {
        n = l.data[nx + ny * mapwidth] - 1;
        if (n >= 0) {
          tileN = tile[n];
          p = mapToCam(nx, ny);
          x = p.x - tilewidth / 2 + tileN.offsetx + l.offsetx;
          y = p.y - tileheight / 2 + tileN.offsety + l.offsety + (tileheight - tileN.image.height);
          ;
          pg.image(tileN.image, x, y);
        }
      }
    }
  }

  private class StaggeredYMap extends Xmap {
    public PVector mapToCanvas(float nx, float ny) {
      float y = ny * (hexsidelength + tileheight) / 2 + tileheight / 2;
      float x = (nx + (float)0.5 + staggerindex / 2) * tilewidth + (staggerindex * 2 - 1) * (abs(abs(y) % 2 - 1) - 1) * (tilewidth) / 2;
      return new PVector(x, y);
    }
    public PVector canvasToMap(float x, float y) {
      float nx;
      float ny = (y * 2 - tileheight) / (hexsidelength + tileheight);
      if (staggerindex == 0) nx = x / tilewidth - 1 + (abs(abs(ny) % 2 - 1)) / 2;
      else nx = x / tilewidth - (float)0.5 - (abs(abs(ny) % 2 - 1)) / 2;
      return new PVector(nx, ny);
    }
    public void drawTileLayer(PGraphics pg, int m) {
      int n;
      float x, y;
      PVector p;
      Tile tileN;
      Layer l = layer[m];
      int xstart = floor(canvasToMap(camleft, camtop).x - drawmargin);
      xstart = max(0, xstart - xstart % 2);
      int xstop = min(mapwidth, ceil(canvasToMap(camleft + pg.width, camtop + pg.height).x + drawmargin));
      int ystart = max(0, floor(canvasToMap(camleft, camtop).y - drawmargin));
      int ystop = min(mapheight, ceil(canvasToMap(camleft + pg.width, camtop + pg.height).y + drawmargin));
      for (int ny = ystart; ny < ystop; ny++) for (int nx = xstart; nx < xstop; nx++) {
        n = l.data[nx + ny * mapwidth] - 1;
        if (n >= 0) {
          tileN = tile[n];
          p = mapToCam(nx, ny);
          x = p.x - tilewidth / 2 + tileN.offsetx + l.offsetx;
          y = p.y - tileheight / 2 + tileN.offsety + l.offsety + (tileheight - tileN.image.height);
          ;
          pg.image(tileN.image, x, y);
        }
      }
    }
  }

  private class Tile {
    private PImage image;
    private int offsetx, offsety;
    Tile(PImage image, int offsetx, int offsety) {
      this.image = image;
      this.offsetx = offsetx;
      this.offsety = offsety;
    }
  }

  private class Layer {
    private String type, name;
    private boolean visible;
    private float offsetx, offsety, opacity;
    private int objcolor;
    private int [] data;
    private PImage image;
    private StringDict [] objects;
    private StringDict properties;
    Layer(String type, String name, boolean visible, float offsetx, float offsety, float opacity, int[] data, PImage image, StringDict [] objects, int objcolor, StringDict properties) {
      this.type = type;
      this.name = name;
      this.visible = visible;
      this.offsetx = offsetx;
      this.offsety = offsety;
      this.opacity = opacity;
      this.data = data;
      this.image = image;
      this.objects = objects;
      this.objcolor = objcolor;
      this.properties = properties;
    }
  }

  public Ptmx(PApplet p, String filename) {
    camwidth = p.width;
    camheight = p.height;
    this.filename = filename;
    XML xml = loadXML(filename);
    if (xml == null) throw new RuntimeException("Not a valid XML File or not UTF-8 encoded");
    if (xml.getName() != "map") throw new RuntimeException("Not a Tmx file (missing 'map' element)");
    loadTmxProperties(xml);
    switch(orientation) {
    case "orthogonal":
      map = new OrthogonalMap();
      break;
    case "isometric":
      map = new IsometricMap();
      break;
    case "staggered":
      hexsidelength = 0;
    case "hexagonal":
      if (staggeraxis.equals("x")) {
        map = new StaggeredXMap();
      } else {
        map = new StaggeredYMap();
      }
      break;
    }
    XML childs[] = xml.getChildren("tileset");
    for (XML e : childs) loadTileset(e);
    childs = xml.getChildren();
    for (XML e : childs) switch(e.getName()) {
    case "layer":
    case "imagelayer":
    case "objectgroup":
      loadLayer(e);
      break;
    }
  }

  private void loadTmxProperties(XML e) {
    version = e.getFloat("version");
    orientation = e.getString("orientation");
    renderorder = e.getString("renderorder");
    mapwidth = e.getInt("width");
    mapheight = e.getInt("height");
    tilewidth = e.getInt("tilewidth");
    tileheight = e.getInt("tileheight");
    staggerindex = 0; 
    if (e.hasAttribute("staggerindex")) if (e.getString("staggerindex").equals("even")) staggerindex = 1;
    staggeraxis = "x"; 
    if (e.hasAttribute("staggeraxis")) staggeraxis = e.getString("staggeraxis");
    hexsidelength = 0; 
    if (e.hasAttribute("hexsidelength")) hexsidelength = e.getInt("hexsidelength");
    backgroundcolor = 0x808080; 
    if (e.hasAttribute("backgroundcolor")) backgroundcolor = readColor(e.getString("backgroundcolor"));
  }

  private void loadTileset(XML e) {
    XML c;
    if (e.hasAttribute("source") && e.getChild("image") == null) {
      loadTileset(loadXML(e.getString("source")));
      return;
    }
    int tilewidth = e.getInt("tilewidth");
    int tileheight = e.getInt("tileheight");
    int tilecount = 0;
    int columns = 0;
    int spacing = 0;
    int margin = 0;
    int tileoffsetx = 0;
    int tileoffsety = 0;
    PImage source, image;
    if (e.hasAttribute("tilecount")) tilecount = e.getInt("tilecount");
    if (e.hasAttribute("columns")) columns = e.getInt("columns");
    if (e.hasAttribute("spacing")) spacing = e.getInt("spacing");
    if (e.hasAttribute("margin")) margin = e.getInt("margin");
    c = e.getChild("tileoffset");
    if (c != null) {
      tileoffsetx = c.getInt("x");
      tileoffsety = c.getInt("y");
    }
    c = e.getChild("image");
    if (c != null) {
      source = loadImage(c.getString("source"));
      if (columns == 0) columns = floor((source.width - margin) / (tilewidth + spacing));
      if (tilecount == 0) tilecount = columns * floor((source.height - margin) / (tileheight + spacing));
      if (c.hasAttribute("trans")) applyTransColor(source, c.getString("trans"));
      for (int n = 0; n < tilecount; n++) {
        image = source.get(margin + (n % columns) * (tilewidth + spacing), margin + floor(n / columns) * (tileheight + spacing), tilewidth, tileheight);
        tile = (Tile[])append(tile, new Tile(image, tileoffsetx, tileoffsety));
      }
    } else {
      XML cs[] = e.getChildren("tile");
      if (cs != null) {
        for (XML t : cs) {
          image = loadImage(t.getChild("image").getString("source"));
          tile = (Tile[])append(tile, new Tile(image, tileoffsetx, tileoffsety));
        }
      }
    }
  }

  private void loadLayer(XML e) {
    String type = "layer";
    String name = e.getString("name");
    boolean visible = true; 
    if (e.hasAttribute("visible")) visible = e.getInt("visible") == 1;
    float offsetx = 0; 
    if (e.hasAttribute("offsetx")) offsetx = e.getFloat("offsetx");
    float offsety = 0; 
    if (e.hasAttribute("offsety")) offsety = e.getFloat("offsety");
    float opacity = 1; 
    if (e.hasAttribute("opacity"))
      opacity = e.getFloat("opacity");
    int objcolor = color(0);
    if (e.hasAttribute("color"))
      objcolor = readColor(e.getString("color"));
    XML c;
    int[] content = null;
    PImage image = null;
    StringDict [] objects = new StringDict[0];
    StringDict properties = new StringDict();
    switch(e.getName()) {
    case "layer":
      c = e.getChild("data");
      if (!(c.getString("encoding").equals("csv"))) throw new RuntimeException("Tmx can only handle CSV encoding");
      content = parseInt(split(c.getContent().replace("\n", ""), ","));
      break;
    case "imagelayer":
      type = "imagelayer";
      c = e.getChild("image");
      image = loadImage(c.getString("source"));
      if (c.hasAttribute("trans")) applyTransColor(image, c.getString("trans"));
      break;
    case "objectgroup":
      type = "objectgroup";
      XML xo[] = e.getChildren("object");
      for (XML o : xo) {
        StringDict prop = new StringDict(); //<>//
        if (o.hasAttribute("gid")) {
          prop.set("object", "tile");
          prop.set("gid", o.getString("gid"));
        } else if (o.getChild("ellipse") != null) prop.set("object", "ellipse");
        else if (o.getChild("polyline") != null) {
          prop.set("object", "polyline");
          prop.set("points", o.getChild("polyline").getString("points"));
        } else if (o.getChild("polygon") != null) { //<>//
          prop.set("object", "polygon");
          prop.set("points", o.getChild("polygon").getString("points"));
        } else prop.set("object", "rectangle");
        if (o.hasAttribute("id")) prop.set("id", o.getString("id"));
        if (o.hasAttribute("name")) prop.set("name", o.getString("name"));
        if (o.hasAttribute("type")) prop.set("type", o.getString("type"));
        if (o.hasAttribute("visible")) prop.set("visible", o.getString("visible"));
        if (o.hasAttribute("x")) prop.set("x", o.getString("x"));
        if (o.hasAttribute("y")) prop.set("y", o.getString("y"));
        if (o.hasAttribute("width")) prop.set("width", o.getString("width"));
        if (o.hasAttribute("height")) prop.set("height", o.getString("height"));
        if (o.hasAttribute("rotation")) prop.set("rotation", o.getString("rotation"));
        if (o.getChild("properties") != null) {
          XML childs[] = o.getChild("properties").getChildren("property");
          for (XML p : childs) prop.set(p.getString("name"), p.getString("value"));
        }
        objects = (StringDict[])append(objects, prop);
      }
      break;
    }
    if (e.getChild("properties") != null) {
      XML childs[] = e.getChild("properties").getChildren("property");
      for (XML p : childs) properties.set(p.getString("name"), p.getString("value"));
    }
    layer = (Layer[])append(layer, new Layer(type, name, visible, offsetx, offsety, opacity, content, image, objects, objcolor, properties));
  }

  private int readColor(String s) {
    if (s.length() == 7 || s.length() == 9) s = s.substring(1);
    if (s.length() == 6) s = "FF" + s;
    return unhex(s);
  }

  private void applyTransColor(PImage source, String c) {
    int trans = readColor(c);
    source.loadPixels();
    for (int p = 0; p < source.pixels.length; p++) if (source.pixels[p] == trans) source.pixels[p] = color(255, 1);
    source.updatePixels();
  }

  private void prepareDraw(PGraphics pg, float left, float top) {
    camwidth = pg.width;
    camheight = pg.height;
    if (positionmode.equals("MAP")) {
      PVector p = mapToCanvas(left, top);
      left = p.x;
      top = p.y;
    }
    if (drawmode == 3) {
      camleft = floor(left - camwidth / 2);
      camtop = floor(top - camheight / 2);
    } else {
      camleft = floor(left);
      camtop = floor(top);
    }
    if (pg != g) pg.beginDraw();
    pg.pushMatrix();
    //pg.resetMatrix();
    pg.pushStyle();
    pg.imageMode(CORNER);
    //pg.clear();
  }

  private void finishDraw(PGraphics pg) {
    pg.popStyle();
    pg.popMatrix();
    if (pg != g) pg.endDraw();
  }

  private void drawLayer(PGraphics pg, int m) {
    //int tileoffsetx, tileoffsety, n, dif;
    //float x = 0, y = 0;
    Layer l = layer[m];
    switch(l.type) {
    case "layer":
      map.drawTileLayer(pg, m);
      break;
    case "imagelayer":
      pg.image(l.image, -camleft + l.offsetx, -camtop + l.offsety);
      break;
    case "objectgroup":
      pg.fill(l.objcolor);
      pg.stroke(l.objcolor); 
      pg.strokeWeight(1);
      for (StringDict o : l.objects) {
        if (!o.hasKey("visible")) {
          pg.pushMatrix();
          pg.resetMatrix();
          pg.pushStyle();
          pg.ellipseMode(CORNER);
          pg.translate(parseFloat(o.get("x")) - l.offsetx - camleft, parseFloat(o.get("y"))- l.offsety - camtop);
          if (o.hasKey("rotation")) pg.rotate(parseFloat(o.get("rotation")) * PI / 180);
          switch(o.get("object")) {
          case "rectangle":
            pg.rect(0, 0, parseFloat(o.get("width")), parseFloat(o.get("height")));
            break;
          case "ellipse":
            pg.ellipse(0, 0, parseFloat(o.get("width")), parseFloat(o.get("height")));
            break;
          case "tile":
            if (o.hasKey("rotation")) pg.rotate(-parseFloat(o.get("rotation")) * PI / 180);
            pg.translate(0, -tile[parseInt(o.get("gid")) - 1].image.height);
            if (o.hasKey("rotation")) pg.rotate(parseFloat(o.get("rotation")) * PI / 180);
            pg.image(tile[parseInt(o.get("gid")) - 1].image, tile[parseInt(o.get("gid")) - 1].offsetx, tile[parseInt(o.get("gid")) - 1].offsety, parseFloat(o.get("width")), parseFloat(o.get("height")));
            break;
          case "polygon":
          case "polyline":
            if (o.get("object").equals("polyline")) pg.noFill();
            pg.beginShape();
            for (String s : split(o.get("points"), " ")) {
              float [] p = parseFloat(split(s, ","));
              pg.vertex(p[0], p[1]);
            }
            if (o.get("object").equals("polyline")) pg.endShape(); 
            else pg.endShape(CLOSE);
            break;
          }
          pg.popStyle();
          pg.popMatrix();
        }
      }
      break;
    }
    if (pg != g && l.opacity < 1) {//applyOpacity
      pg.loadPixels();
      int a = parseInt(map(l.opacity, 0, 1, 1, 255));
      for (int p = 0; p < pg.pixels.length; p++) if (alpha(pg.pixels[p]) > a) pg.pixels[p] = color(red(pg.pixels[p]), green(pg.pixels[p]), blue(pg.pixels[p]), a);
      pg.updatePixels();
    }
  }

  //Public methods
  //Draw Methods

  public void draw() {
    draw(g, 0, 0);
  }

  public void draw(PVector p) {
    draw(g, floor(p.x), floor(p.y));
  }

  public void draw(float left, float top) {
    draw(g, left, top);
  }

  public void draw(int n, PVector p) {
    draw(g, n, p.x, p.y);
  }

  public void draw(int n, float left, float top) {
    draw(g, n, left, top);
  }

  public void draw(PGraphics pg) {
    draw(pg, 0, 0);
  }

  public void draw(PGraphics pg, PVector p) {
    draw(pg, p.x, p.y);
  }

  public void draw(PGraphics pg, float left, float top) {
    prepareDraw(pg, left, top);
    for (int n = 0; n < layer.length; n++) if (layer[n].visible) drawLayer(pg, n);
    finishDraw(pg);
  }

  public void draw(PGraphics pg, int n, PVector p) {
    draw(pg, n, p.x, p.y);
  }

  public void draw(PGraphics pg, int n, float left, float top) {
    if (n >= 0 && n < layer.length) {
      prepareDraw(pg, left, top);
      drawLayer(pg, n);
      finishDraw(pg);
    }
  }

  //Layers methods

  public String getType(int n) {
    if (n >= 0 && n < layer.length) return layer[n].type;
    else return null;
  }

  public boolean getVisible(int n) {
    if (n >= 0 && n < layer.length) return layer[n].visible;
    else return false;
  }

  public void setVisible(int n, boolean v) {
    if (n >= 0 && n < layer.length) layer[n].visible = v;
  }

  public PImage getImage(int n) {
    if (n >= 0 && n < layer.length && layer[n].type.equals("imagelayer")) return layer[n].image;
    else return null;
  }

  public StringDict[] getObjects(int n) {
    if (n >= 0 && n < layer.length && layer[n].type.equals("objectgroup")) return layer[n].objects;
    else return null;
  }

  public int getObjectsColor(int n) {
    if (n >= 0 && n < layer.length && layer[n].type.equals("objectgroup")) return layer[n].objcolor;
    else return 0;
  }

  public int[] getData(int n) {
    if (n >= 0 && n < layer.length && layer[n].type.equals("layer")) return layer[n].data;
    else return null;
  }

  public StringDict getCustomProperties(int n) {
    if (n >= 0 && n < layer.length) return layer[n].properties;
    else return null;
  }

  public float getOpacity(int n) {
    if (n >= 0 && n < layer.length) return layer[n].opacity;
    else return 0;
  }

  public void setOpacity(int n, float o) {
    if (n >= 0 && n < layer.length && o >= 0 && o <=1) layer[n].opacity = min(max(0, o), 1);
  }

  public int getTileIndex(int n, int x, int y) {
    if (n >= 0 && n < layer.length && x >= 0 && y >= 0 && x < mapwidth && y < mapheight && layer[n].type.equals("layer")) return layer[n].data[x + y * mapwidth] - 1;
    else return -2;
  }

  public void setTileIndex(int n, int x, int y, int v) {
    if (n >= 0 && n < layer.length && x >= 0 && y >= 0 && x < mapwidth && y < mapheight && layer[n].type.equals("layer") && v >= -1) layer[n].data[x + y * mapwidth] = v + 1;
  }

  public void toImage(int n) {
    if (n >= 0 && n < layer.length) {
      Layer l = layer[n];
      int fw = camwidth;
      int fh = camheight;
      int ml = camleft;
      int mt = camtop;
      boolean v = l.visible;
      PGraphics conv;
      l.visible = true;
      camleft = 0;
      camtop = 0;
      switch(orientation) {
      case "orthogonal":
        camwidth = mapwidth * tilewidth;
        camheight = mapheight * tileheight;
        break;
      case "isometric":
        camwidth = (mapwidth + mapheight) * tilewidth / 2;
        camheight = (mapwidth + mapheight) * tileheight / 2;
        break;
      case "staggered":
      case "hexagonal":
        if (staggeraxis.equals("x")) {
          camwidth = (mapwidth + 1) * (hexsidelength + tilewidth) / 2;
          camheight = (mapheight + 1) * (hexsidelength + tileheight);
        } else {
          camwidth = (mapwidth + 1) * (hexsidelength + tilewidth);
          camheight = (mapheight + 1) * (hexsidelength + tileheight) / 2;
        }
        break;
      }
      conv = createGraphics(camwidth, camheight);
      conv.beginDraw();
      drawLayer(conv, n);
      conv.endDraw();
      l.image = conv;
      l.data = null;
      l.objects = null;
      l.type = "imagelayer";
      l.visible = v;
      l.offsetx = 0;
      l.offsety = 0;
      camwidth = fw;
      camheight = fh;
      camleft = ml;
      camtop = mt;
    }
  }

  //Map methods

  public String getFilename() {
    return filename;
  }

  public float getVersion() {
    return version;
  }

  public int getBackgroundColor() {
    return backgroundcolor;
  }

  public PVector getMapSize() {
    return new PVector(mapwidth, mapheight);
  }

  public PVector getTileSize() {
    return new PVector(tilewidth, tileheight);
  }

  public int getHexSideLength() {
    return hexsidelength;
  }

  public PVector getCamCorner() {
    if (positionmode.equals("MAP")) return canvasToMap(camleft, camtop);
    else return new PVector(camleft, camtop);
  }

  public PVector getCamCenter() {
    if (positionmode.equals("MAP")) return canvasToMap(camleft + camwidth / 2, camtop + camheight / 2);
    else return new PVector(camleft + camwidth / 2, camtop + camheight / 2);
  }

  public PVector getCamSize() {
    return new PVector(camwidth, camheight);
  }

  public void setCamSize(PVector s) { //Only useful for some pre-draw calculations, since size is always the last PGraphics used.
    setCamSize(floor(s.x), floor(s.y));
  }

  public void setCamSize(int w, int h) {
    camwidth = w;
    camheight = h;
  }

  public int getDrawMargin() {
    return drawmargin;
  }

  public void setDrawMargin(int n) { //for orthogonal maps
    drawmargin = max(1, n);
  }

  public int getDrawMode() {//CORNER or CENTER
    return drawmode;
  }

  public void setDrawMode(int s) {
    if (s == CORNER || s == CENTER) drawmode = s;
  }

  public String getPositionMode() {//"CANVAS" or "MAP"
    return positionmode;
  }

  public void setPositionMode(String s) {
    if (s.equals("CANVAS") || s.equals("MAP")) positionmode = s;
  }

  public PVector getPosition() {
    if (drawmode == CORNER) return getCamCorner();
    else return getCamCenter();
  }

  //Coordinate methods

  public PVector canvasToMap(PVector p) {
    return canvasToMap(p.x, p.y);
  }

  public PVector canvasToMap(float x, float y) {
    return map.canvasToMap(x, y);
  }

  public PVector mapToCanvas(PVector p) {
    return mapToCanvas(p.x, p.y);
  }

  public PVector mapToCanvas(float nx, float ny) {
    return map.mapToCanvas(nx, ny);
  }

  public PVector camToCanvas(PVector p) {
    return camToCanvas(p.x, p.y);
  }

  public PVector camToCanvas(float x, float y) {
    return new PVector(x + camleft, y + camtop);
  }

  public PVector canvasToCam(PVector p) {
    return canvasToCam(p.x, p.y);
  }

  public PVector canvasToCam(float x, float y) {
    return new PVector(x - camleft, y - camtop);
  }

  public PVector camToMap(PVector p) {
    return camToMap(p.x, p.y);
  }

  public PVector camToMap(float x, float y) {
    return canvasToMap(camToCanvas(x, y));
  }

  public PVector mapToCam(PVector p) {
    return mapToCam(p.x, p.y);
  }

  public PVector mapToCam(float nx, float ny) {
    return canvasToCam(mapToCanvas(nx, ny));
  }
}