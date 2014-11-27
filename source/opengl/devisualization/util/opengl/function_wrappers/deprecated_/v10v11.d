module devisualization.util.opengl.function_wrappers.deprecated_.v10v11;
import gl = derelict.opengl3.gl;
public import derelict.opengl3.gl : glEnd, glListBase, glCallList, glEndList, glGenLists, glDeleteLists, glIsList, glLineStipple;

enum ListMode {
    Compile = gl.GL_COMPILE,
    CompileAndExecute = gl.GL_COMPILE_AND_EXECUTE
}

enum CallListSizes {
    UnsignedByte = gl.GL_UNSIGNED_BYTE,
    Byte = gl.GL_BYTE,
    UnsignedShort = gl.GL_UNSIGNED_SHORT,
    Short = gl.GL_SHORT,
    UnsignedInt = gl.GL_UNSIGNED_INT,
    Int = gl.GL_INT,
    Float = gl.GL_FLOAT,
    Bytes2 = gl.GL_2_BYTES,
    Bytes3 = gl.GL_3_BYTES,
    Bytes4 = gl.GL_4_BYTES
}

enum BeginPrimitives {
    Points = gl.GL_POINTS,
    LineStrip = gl.GL_LINE_STRIP,
    LineLoop = gl.GL_LINE_LOOP,
    Lines = gl.GL_LINES,
    TriangleStrip = gl.GL_TRIANGLE_STRIP,
    TriangleFan = gl.GL_TRIANGLE_FAN,
    Triangles = gl.GL_TRIANGLES,
    Quads = gl.GL_QUADS,
    QuadStrip = gl.GL_QUAD_STRIP,
    Polygon = gl.GL_POLYGON,
}

enum LightSource {
    SpotExponent = gl.GL_SPOT_EXPONENT,
    SpotCutOff = gl.GL_SPOT_CUTOFF,
    ConstantAttenuation = gl.GL_CONSTANT_ATTENUATION,
    LinearAttenuation = gl.GL_LINEAR_ATTENUATION,
    QuadraticAttenuation  = gl.GL_QUADRATIC_ATTENUATION
}

enum MaterialType {
    Ambient = gl.GL_AMBIENT,
    Diffuse = gl.GL_DIFFUSE,
    Specular = gl.GL_SPECULAR,
    Emission = gl.GL_EMISSION
}

enum ShadeModel {
    Flat = gl.GL_FLAT,
    Smooth = gl.GL_SMOOTH
}

enum MaterialFace {
    Front = gl.GL_FRONT,
    Back = gl.GL_BACK,
    FrontAndBack = gl.GL_FRONT_AND_BACK
}

enum FogType {
    FogMode = gl.GL_FOG_MODE,
    FogDensity = gl.GL_FOG_DENSITY,
    FogStart = gl.GL_FOG_START,
    FogEnd = gl.GL_FOG_END,
    FogIndex = gl.GL_FOG_INDEX,
    FogCoordSource = gl.GL_FOG_COORD_SRC
}

void glNewList(uint list, ListMode mode) {
    gl.glNewList(list, mode);
}

void glCallLists(T)(CallListSizes type, T[] lists) {
    gl.glCallLists(lists.length, type, lists.ptr);
}

void glBegin(BeginPrimitives mode) {
    gl.glBegin(mode);
}

void glVertex(short a, short b)
    { gl.glVertex2s(a, b); }
void glVertex(int a, int b)
    { gl.glVertex2i(a, b); }
void glVertex(float a, float b)
    { gl.glVertex2f(a, b); }
void glVertex(double a, double b)
    { gl.glVertex2d(a, b); }

void glVertex(short a, short b, short c)
    { gl.glVertex3s(a, b, c); }
void glVertex(int a, int b, int c)
    { gl.glVertex3i(a, b, c); }
void glVertex(float a, float b, float c)
    { gl.glVertex3f(a, b, c); }
void glVertex(double a, double b, double c)
    { gl.glVertex3d(a, b, c); }

void glVertex(short a, short b, short c, short d)
    { gl.glVertex4s(a, b, c, d); }
void glVertex(int a, int b, int c, int d)
    { gl.glVertex4i(a, b, c, d); }
void glVertex(float a, float b, float c, float d)
    { gl.glVertex4f(a, b, c, d); }
void glVertex(double a, double b, double c, double d)
    { gl.glVertex4d(a, b, c, d); }

void glVertex(short[] value)
in {
    assert(value.length >= 2 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 2)
        gl.glVertex2sv(value.ptr);
    else if (value.length == 3)
        gl.glVertex3sv(value.ptr);
    else if (value.length == 4)
        gl.glVertex4sv(value.ptr);
}

void glVertex(int[] value)
in {
    assert(value.length >= 2 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 2)
        gl.glVertex2iv(value.ptr);
    else if (value.length == 3)
        gl.glVertex3iv(value.ptr);
    else if (value.length == 4)
        gl.glVertex4iv(value.ptr);
}

void glVertex(float[] value)
in {
    assert(value.length >= 2 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 2)
        gl.glVertex2fv(value.ptr);
    else if (value.length == 3)
        gl.glVertex3fv(value.ptr);
    else if (value.length == 4)
        gl.glVertex4fv(value.ptr);
}

void glVertex(double[] value)
in {
    assert(value.length >= 2 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 2)
        gl.glVertex2dv(value.ptr);
    else if (value.length == 3)
        gl.glVertex3dv(value.ptr);
    else if (value.length == 4)
        gl.glVertex4dv(value.ptr);
}

void glNormal(byte a, byte b, byte c)
    { gl.glNormal3b(a, b, c); }
void glNormal(double a, double b, double c)
    { gl.glNormal3d(a, b, c); }
void glNormal(float a, float b, float c)
    { gl.glNormal3f(a, b, c); }
void glNormal(int a, int b, int c)
    { gl.glNormal3i(a, b, c); }
void glNormal(short a, short b, short c)
    { gl.glNormal3s(a, b, c); }

void glNormal(byte[] value)
    in { assert(value.length == 3); }
    body { gl.glNormal3bv(cast(const)value.ptr); }
void glNormal(double[] value)
    in { assert(value.length == 3); }
    body { gl.glNormal3dv(value.ptr); }
void glNormal(float[] value)
    in { assert(value.length == 3); }
    body { gl.glNormal3fv(value.ptr); }
void glNormal(int[] value)
    in { assert(value.length == 3); }
    body { gl.glNormal3iv(value.ptr); }
void glNormal(short[] value)
    in { assert(value.length == 3); }
    body { gl.glNormal3sv(value.ptr); }

void glIndex(double value) { gl.glIndexd(value); }
void glIndex(float value) { gl.glIndexf(value); }
void glIndex(int value) { gl.glIndexi(value); }
void glIndex(short value) { gl.glIndexs(value); }
void glIndex(ubyte value) { gl.glIndexub(value); }

/*
alias da_glIndexdv = void function( const( GLdouble )* );
alias da_glIndexfv = void function( const( GLfloat )* );
alias da_glIndexiv = void function( const( GLint )* );
alias da_glIndexsv = void function( const( GLshort )* );
alias da_glIndexubv = void function( const( GLubyte )* );*/

void glColor(byte a, byte b, byte c) { gl.glColor3b(a, b, c); }
void glColor(double a, double b, double c) { gl.glColor3d(a, b, c); }
void glColor(float a, float b, float c) { gl.glColor3f(a, b, c); }
void glColor(int a, int b, int c) { gl.glColor3i(a, b, c); }
void glColor(short a, short b, short c) { gl.glColor3s(a, b, c); }

void glColor(ubyte a, ubyte b, ubyte c) { gl.glColor3ub(a, b, c); }
void glColor(uint a, uint b, uint c) { gl.glColor3ui(a, b, c); }
void glColor(ushort a, ushort b, ushort c) { gl.glColor3us(a, b, c); }

void glColor(byte a, byte b, byte c, byte d) { gl.glColor4b(a, b, c, d); }
void glColor(double a, double b, double c, double d) { gl.glColor4d(a, b, c, d); }
void glColor(float a, float b, float c, float d) { gl.glColor4f(a, b, c, d); }
void glColor(int a, int b, int c, int d) { gl.glColor4i(a, b, c, d); }
void glColor(short a, short b, short c, short d) { gl.glColor4s(a, b, c, d); }

void glColor(ubyte a, ubyte b, ubyte c, byte d) { gl.glColor4ub(a, b, c, d); }
void glColor(uint a, uint b, uint c, uint d) { gl.glColor4ui(a, b, c, d); }
void glColor(ushort a, ushort b, ushort c, ushort d) { gl.glColor4us(a, b, c, d); }

void glColor(byte[] value)
in {
    assert(value.length >= 3 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 3)
        gl.glColor3bv(value.ptr);
    else if (value.length == 4)
        gl.glColor4bv(value.ptr);
}

void glColor(double[] value)
in {
    assert(value.length >= 3 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 3)
        gl.glColor3dv(value.ptr);
    else if (value.length == 4)
        gl.glColor4dv(value.ptr);
}

void glColor(float[] value)
in {
    assert(value.length >= 3 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 3)
        gl.glColor3fv(value.ptr);
    else if (value.length == 4)
        gl.glColor4fv(value.ptr);
}

void glColor(int[] value)
in {
    assert(value.length >= 3 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 3)
        gl.glColor3iv(value.ptr);
    else if (value.length == 4)
        gl.glColor4iv(value.ptr);
}

void glColor(short[] value)
in {
    assert(value.length >= 3 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 3)
        gl.glColor3sv(value.ptr);
    else if (value.length == 4)
        gl.glColor4sv(value.ptr);
}

void glColor(ubyte[] value)
in {
    assert(value.length >= 3 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 3)
        gl.glColor3ubv(value.ptr);
    else if (value.length == 4)
        gl.glColor4ubv(value.ptr);
}

void glColor(uint[] value)
in {
    assert(value.length >= 3 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 3)
        gl.glColor3uiv(value.ptr);
    else if (value.length == 4)
        gl.glColor4uiv(value.ptr);
}

void glColor(ushort[] value)
in {
    assert(value.length >= 3 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 3)
        gl.glColor3usv(value.ptr);
    else if (value.length == 4)
        gl.glColor4usv(value.ptr);
}

void glTexCoord(double a) { gl.glTexCoord1d(a); }
void glTexCoord(float a) { gl.glTexCoord1f(a); }
void glTexCoord(int a) { gl.glTexCoord1i(a); }
void glTexCoord(short a) { gl.glTexCoord1s(a); }

void glTexCoord(double a, double b) { gl.glTexCoord2d(a, b); }
void glTexCoord(float a, float b) { gl.glTexCoord2f(a, b); }
void glTexCoord(int a, int b) { gl.glTexCoord2i(a, b); }
void glTexCoord(short a, short b) { gl.glTexCoord2s(a, b); }

void glTexCoord(double a, double b, double c) { gl.glTexCoord3d(a, b, c); }
void glTexCoord(float a, float b, float c) { gl.glTexCoord3f(a, b, c); }
void glTexCoord(int a, int b, int c) { gl.glTexCoord3i(a, b, c); }
void glTexCoord(short a, short b, short c) { gl.glTexCoord3s(a, b, c); }

void glTexCoord(double a, double b, double c, double d) { gl.glTexCoord4d(a, b, c, d); }
void glTexCoord(float a, float b, float c, float d) { gl.glTexCoord4f(a, b, c, d); }
void glTexCoord(int a, int b, int c, int d) { gl.glTexCoord4i(a, b, c, d); }
void glTexCoord(short a, short b, short c, short d) { gl.glTexCoord4s(a, b, c, d); }

void glTexCoord(double[] value)
in {
    assert(value.length >= 1 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 1)
        gl.glTexCoord1dv(value.ptr);
    else if (value.length == 2)
        gl.glTexCoord2dv(value.ptr);
    else if (value.length == 3)
        gl.glTexCoord3dv(value.ptr);
    else if (value.length == 4)
        gl.glTexCoord4dv(value.ptr);
}

void glTexCoord(float[] value)
in {
    assert(value.length >= 3 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 1)
        gl.glTexCoord1fv(value.ptr);
    else if (value.length == 2)
        gl.glTexCoord2fv(value.ptr);
    else if (value.length == 3)
        gl.glTexCoord3fv(value.ptr);
    else if (value.length == 4)
        gl.glTexCoord4fv(value.ptr);
}

void glTexCoord(int[] value)
in {
    assert(value.length >= 3 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 1)
        gl.glTexCoord1iv(value.ptr);
    else if (value.length == 2)
        gl.glTexCoord2iv(value.ptr);
    else if (value.length == 3)
        gl.glTexCoord3iv(value.ptr);
    else if (value.length == 4)
        gl.glTexCoord4iv(value.ptr);
}

void glTexCoord(short[] value)
in {
    assert(value.length >= 3 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 1)
        gl.glTexCoord1sv(value.ptr);
    else if (value.length == 2)
        gl.glTexCoord2sv(value.ptr);
    else if (value.length == 3)
        gl.glTexCoord3sv(value.ptr);
    else if (value.length == 4)
        gl.glTexCoord4sv(value.ptr);
}

void glRasterPos(double a, double b) { gl.glRasterPos2d(a, b); }
void glRasterPos(float a, float b) { gl.glRasterPos2f(a, b); }
void glRasterPos(int a, int b) { gl.glRasterPos2i(a, b); }
void glRasterPos(short a, short b) { gl.glRasterPos2s(a, b); }

void glRasterPos(double a, double b, double c) { gl.glRasterPos3d(a, b, c); }
void glRasterPos(float a, float b, float c) { gl.glRasterPos3f(a, b, c); }
void glRasterPos(int a, int b, int c) { gl.glRasterPos3i(a, b, c); }
void glRasterPos(short a, short b, short c) { gl.glRasterPos3s(a, b, c); }

void glRasterPos(double a, double b, double c, double d) { gl.glRasterPos4d(a, b, c, d); }
void glRasterPos(float a, float b, float c, float d) { gl.glRasterPos4f(a, b, c, d); }
void glRasterPos(int a, int b, int c, int d) { gl.glRasterPos4i(a, b, c, d); }
void glRasterPos(short a, short b, short c, short d) { gl.glRasterPos4s(a, b, c, d); }

void glRasterPos(double[] value)
in {
    assert(value.length >= 2 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 2)
        gl.glRasterPos2dv(value.ptr);
    else if (value.length == 3)
        gl.glRasterPos3dv(value.ptr);
    else if (value.length == 4)
        gl.glRasterPos4dv(value.ptr);
}

void glRasterPos(float[] value)
in {
    assert(value.length >= 2 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 2)
        gl.glRasterPos2fv(value.ptr);
    else if (value.length == 3)
        gl.glRasterPos3fv(value.ptr);
    else if (value.length == 4)
        gl.glRasterPos4fv(value.ptr);
}

void glRasterPos(int[] value)
in {
    assert(value.length >= 2 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 2)
        gl.glRasterPos2iv(value.ptr);
    else if (value.length == 3)
        gl.glRasterPos3iv(value.ptr);
    else if (value.length == 4)
        gl.glRasterPos4iv(value.ptr);
}

void glRasterPos(short[] value)
in {
    assert(value.length >= 2 && value.length <= 4, "Invalid array length");
} body {
    if (value.length == 2)
        gl.glRasterPos2sv(value.ptr);
    else if (value.length == 3)
        gl.glRasterPos3sv(value.ptr);
    else if (value.length == 4)
        gl.glRasterPos4sv(value.ptr);
}

void glRect(double a, double b, double c, double d) { gl.glRectd(a, b, c, d); }
void glRect(float a, float b, float c, float d) { gl.glRectf(a, b, c, d); }
void glRect(int a, int b, int c, int d) { gl.glRecti(a, b, c, d); }
void glRect(short a, short b, short c, short d) { gl.glRects(a, b, c, d); }

/*
alias da_glRectdv = void function( const( GLdouble )*, const( GLdouble )* );
alias da_glRectfv = void function( const( GLfloat )*, const( GLfloat )* );
alias da_glRectiv = void function( const( GLint )*, const( GLint )* );
alias da_glRectsv = void function( const( GLshort )*, const( GLshort )* );*/

void glClipPlane(uint i, double[] plane)
    in { assert(plane.length == 4); }
    body { gl.glClipPlane(i, plane.ptr); }

double[4] glGetClipPlane(uint i) {
    double[4] ret;
    gl.glGetClipPlane(i, ret.ptr);
    return ret;
}

void glShadeModel(ShadeModel mode) { gl.glShadeModel(mode); }

void glLight(uint light, LightSource name, float param) { gl.glLightf(light, name, param); }
void glLight(uint light, LightSource name, int param) { gl.glLightf(light, name, param); }

/*
alias da_glLightfv = void function( GLenum,GLenum,const( GLfloat )* );
alias da_glLightiv = void function( GLenum,GLenum,const( GLint )* );
alias da_glGetLightfv = void function( GLenum,GLenum,GLfloat* );
alias da_glGetLightiv = void function( GLenum,GLenum,GLint* );*/

void glLightModelf(float param) { gl.glLightModelf(gl.GL_LIGHT_MODEL_TWO_SIDE, param); }
void glLightModeli(int param) { gl.glLightModeli(gl.GL_LIGHT_MODEL_TWO_SIDE, param); }

/*
alias da_glLightModelfv = void function( GLenum,const( GLfloat )* );
alias da_glLightModeliv = void function( GLenum,const( GLint )* );*/

void glMaterial(float param) { gl.glMaterialf(gl.GL_FRONT_AND_BACK, gl.GL_SHININESS, param); }
void glMaterial(int param) { gl.glMateriali(gl.GL_FRONT_AND_BACK, gl.GL_SHININESS, param); }

/*
alias da_glMaterialfv = void function( GLenum,GLenum,const( GLfloat )* );
alias da_glMaterialiv = void function( GLenum,GLenum,const( GLint )* );*/

void glGetMaterial(bool frontFace, MaterialType name, out float param) { gl.glGetMaterialfv(frontFace ? gl.GL_FRONT : gl.GL_BACK, name, &param); }
void glGetMaterial(bool frontFace, MaterialType name, out int param) { gl.glGetMaterialiv(frontFace ? gl.GL_FRONT : gl.GL_BACK, name, &param); }
void glColorMaterial(MaterialFace face, MaterialType type) { gl.glColorMaterial(face, type); }

void glFog(FogType name, float param) { gl.glFogf(name, param); }
void glFog(FogType name, int param) { gl.glFogi(name, param); }

/*NOT DOING
alias da_glFogfv = void function( GLenum,const( GLfloat )* );
alias da_glFogiv = void function( GLenum,const( GLint )* );
alias da_glPolygonStipple = void function( const( GLubyte )* );
alias da_glGetPolygonStipple = void function( GLubyte* );*/

/*
alias da_glTexGend = void function( GLenum,GLenum,GLdouble );
alias da_glTexGenf = void function( GLenum,GLenum,GLfloat );
alias da_glTexGeni = void function( GLenum,GLenum,GLint );
alias da_glTexGendv = void function( GLenum,GLenum,const( GLdouble )* );
alias da_glTexGenfv = void function( GLenum,GLenum,const( GLfloat )* );
alias da_glTexGeniv = void function( GLenum,GLenum,const( GLint )* );*/

/*
alias da_glGetTexGendv = void function( GLenum,GLenum,GLdouble* );
alias da_glGetTexGenfv = void function( GLenum,GLenum,GLfloat* );
alias da_glGetTexGeniv = void function( GLenum,GLenum,GLint* );
alias da_glTexEnvf = void function( GLenum,GLenum,GLfloat );
alias da_glTexEnvi = void function( GLenum,GLenum,GLint );
alias da_glTexEnvfv = void function( GLenum,GLenum,const( GLfloat )* );
alias da_glTexEnviv = void function( GLenum,GLenum,const( GLint )* );
alias da_glGetTexEnvfv = void function( GLenum,GLenum,GLfloat* );
alias da_glGetTexEnviv = void function( GLenum,GLenum,GLint* );*/

/*
alias da_glFeedbackBuffer = void function( GLsizei,GLenum,GLfloat* );
alias da_glPassThrough = void function( GLfloat );
alias da_glSelectBuffer = void function( GLsizei,GLuint* );
alias da_glInitNames = void function();
alias da_glLoadName = void function( GLuint );
alias da_glPushName = void function( GLuint );
alias da_glPopName = void function();
alias da_glRenderMode = GLint function( GLenum );*/

/*
alias da_glClearAccum = void function( GLfloat,GLfloat,GLfloat,GLfloat );
alias da_glAccum = void function( GLenum,GLfloat );
alias da_glClearIndex = void function( GLfloat c );
alias da_glIndexMask = void function( GLuint );
alias da_glPushAttrib = void function( GLbitfield );
alias da_glPopAttrib = void function();*/

/*
alias da_glMap1d = void function( GLenum,GLdouble,GLdouble,GLint,GLint,const( GLdouble )* );
alias da_glMap1f = void function( GLenum,GLfloat,GLfloat,GLint,GLint,const( GLfloat )* );
alias da_glMap2d = void function( GLenum,GLdouble,GLdouble,GLint,GLint,GLdouble,GLdouble,GLint,GLint,GLdouble* );
alias da_glMap2f = void function( GLenum,GLfloat,GLfloat,GLint,GLint,GLfloat,GLfloat,GLint,GLint,GLfloat* );
alias da_glGetMapdv = void function( GLenum,GLenum,GLdouble* );
alias da_glGetMapfv = void function( GLenum,GLenum,GLfloat* );
alias da_glGetMapiv = void function( GLenum,GLenum,GLint* );*/

/*
alias da_glEvalCoord1d = void function( GLdouble );
alias da_glEvalCoord1f = void function( GLfloat );
alias da_glEvalCoord1dv = void function( const( GLdouble )* );
alias da_glEvalCoord1fv = void function( const( GLfloat )* );
alias da_glEvalCoord2d = void function( GLdouble,GLdouble );
alias da_glEvalCoord2f = void function( GLfloat,GLfloat );
alias da_glEvalCoord2dv = void function( const( GLdouble )* );
alias da_glEvalCoord2fv = void function( const( GLfloat )* );*/

/*
alias da_glMapGrid1d = void function( GLint,GLdouble,GLdouble );
alias da_glMapGrid1f = void function( GLint,GLfloat,GLfloat );
alias da_glMapGrid2d = void function( GLint,GLdouble,GLdouble,GLint,GLdouble,GLdouble );
alias da_glMapGrid2f = void function( GLint,GLfloat,GLfloat,GLint,GLfloat,GLfloat );
alias da_glEvalPoint1 = void function( GLint );
alias da_glEvalPoint2 = void function( GLint,GLint );
alias da_glEvalMesh1 = void function( GLenum,GLint,GLint );
alias da_glEvalMesh2 = void function( GLenum,GLint,GLint,GLint,GLint );*/

/*
alias da_glAlphaFunc = void function( GLenum,GLclampf );
alias da_glPixelZoom = void function( GLfloat,GLfloat );
alias da_glPixelTransferf = void function( GLenum,GLfloat );
alias da_glPixelTransferi = void function( GLenum,GLint );
alias da_glPixelMapfv = void function( GLenum,GLint,const( GLfloat )* );
alias da_glPixelMapuiv = void function( GLenum,GLint,const( GLuint )* );
alias da_glPixelMapusv = void function( GLenum,GLint,const( GLushort )* );
alias da_glGetPixelMapfv = void function( GLenum,GLfloat* );
alias da_glGetPixelMapuiv = void function( GLenum,GLuint* );
alias da_glGetPixelMapusv = void function( GLenum,GLushort* );*/

/*
alias da_glDrawPixels = void function( GLsizei,GLsizei,GLenum,GLenum,const( void )* );
alias da_glCopyPixels = void function( GLint,GLint,GLsizei,GLsizei,GLenum );
alias da_glFrustum = void function( GLdouble,GLdouble,GLdouble,GLdouble,GLdouble,GLdouble );
alias da_glMatrixMode = void function( GLenum );
alias da_glOrtho = void function( GLdouble,GLdouble,GLdouble,GLdouble,GLdouble,GLdouble );
alias da_glPushMatrix = void function();
alias da_glPopMatrix = void function();
alias da_glLoadIdentity = void function();*/

/*
alias da_glLoadMatrixd = void function( const( GLdouble )* );
alias da_glLoadMatrixf = void function( const( GLfloat )* );
alias da_glMultMatrixd = void function( const( GLdouble )* );
alias da_glMultMatrixf = void function( const( GLfloat )* );*/

/*
alias da_glRotated = void function( GLdouble,GLdouble,GLdouble,GLdouble );
alias da_glRotatef = void function( GLfloat,GLfloat,GLfloat,GLfloat );
alias da_glScaled = void function( GLdouble,GLdouble,GLdouble );
alias da_glScalef = void function( GLfloat,GLfloat,GLfloat );
alias da_glTranslated = void function( GLdouble,GLdouble,GLdouble );
alias da_glTranslatef = void function( GLfloat,GLfloat,GLfloat );*/

/*
alias da_glVertexPointer = void function( GLint,GLenum,GLsizei,const( void )* );
alias da_glNormalPointer = void function( GLenum,GLsizei,const( void )* );
alias da_glColorPointer = void function( GLint,GLenum,GLsizei,const( void )* );
alias da_glIndexPointer = void function( GLenum,GLsizei,const( void )* );
alias da_glTexCoordPointer = void function( GLint,GLenum,GLsizei,const( void )* );
alias da_glEdgeFlagPointer = void function( GLsizei,const( void )* );*/

/*
alias da_glArrayElement = void function( GLint );
alias da_glInterleavedArrays = void function( GLenum,GLsizei,const( void )* );
alias da_glEnableClientState = void function( GLenum );
alias da_glDisableClientState = void function( GLenum );
alias da_glPrioritizeTextures = void function( GLsizei,const( GLuint )*,const( GLclampf )* );
alias da_glAreTexturesResident = GLboolean function( GLsizei,const( GLuint )*,GLboolean* );
alias da_glPushClientAttrib = void function( GLbitfield );
alias da_glPopClientAttrib = void function();*/
