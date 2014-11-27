module devisualization.util.opengl.function_wrappers.deprecated_.v10v11;
import gl = derelict.opengl3.gl;
public import derelict.opengl3.gl : glEnd, glListBase, glCallList, glEndList, glGenLists, glDeleteLists, glIsList;

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
    Polygon = gl.GL_POLYGON
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

/*alias da_glTexCoord1d = void function( GLdouble );
alias da_glTexCoord1f = void function( GLfloat );
alias da_glTexCoord1i = void function( GLint );
alias da_glTexCoord1s = void function( GLshort );
alias da_glTexCoord2d = void function( GLdouble,GLdouble );
alias da_glTexCoord2f = void function( GLfloat,GLfloat );
alias da_glTexCoord2i = void function( GLint,GLint );
alias da_glTexCoord2s = void function( GLshort,GLshort );
alias da_glTexCoord3d = void function( GLdouble,GLdouble,GLdouble );
alias da_glTexCoord3f = void function( GLfloat,GLfloat,GLfloat );
alias da_glTexCoord3i = void function( GLint,GLint,GLint );
alias da_glTexCoord3s = void function( GLshort,GLshort,GLshort );
alias da_glTexCoord4d = void function( GLdouble,GLdouble,GLdouble,GLdouble );
alias da_glTexCoord4f = void function( GLfloat,GLfloat,GLfloat,GLfloat );
alias da_glTexCoord4i = void function( GLint,GLint,GLint,GLint );
alias da_glTexCoord4s = void function( GLshort,GLshort,GLshort,GLshort );
alias da_glTexCoord1dv = void function( const( GLdouble )* );
alias da_glTexCoord1fv = void function( const( GLfloat )* );
alias da_glTexCoord1iv = void function( const( GLint )* );
alias da_glTexCoord1sv = void function( const( GLshort )* );
alias da_glTexCoord2dv = void function( const( GLdouble )* );
alias da_glTexCoord2fv = void function( const( GLfloat )* );
alias da_glTexCoord2iv = void function( const( GLint )* );
alias da_glTexCoord2sv = void function( const( GLshort )* );
alias da_glTexCoord3dv = void function( const( GLdouble )* );
alias da_glTexCoord3fv = void function( const( GLfloat )* );
alias da_glTexCoord3iv = void function( const( GLint )* );
alias da_glTexCoord3sv = void function( const( GLshort )* );
alias da_glTexCoord4dv = void function( const( GLdouble )* );
alias da_glTexCoord4fv = void function( const( GLfloat )* );
alias da_glTexCoord4iv = void function( const( GLint )* );
alias da_glTexCoord4sv = void function( const( GLshort )* );*/

/*alias da_glRasterPos2d = void function( GLdouble,GLdouble );
alias da_glRasterPos2f = void function( GLfloat,GLfloat );
alias da_glRasterPos2i = void function( GLint,GLint );
alias da_glRasterPos2s = void function( GLshort,GLshort );
alias da_glRasterPos3d = void function( GLdouble,GLdouble,GLdouble );
alias da_glRasterPos3f = void function( GLfloat,GLfloat,GLfloat );
alias da_glRasterPos3i = void function( GLint,GLint,GLint );
alias da_glRasterPos3s = void function( GLshort,GLshort,GLshort );
alias da_glRasterPos4d = void function( GLdouble,GLdouble,GLdouble,GLdouble );
alias da_glRasterPos4f = void function( GLfloat,GLfloat,GLfloat,GLfloat );
alias da_glRasterPos4i = void function( GLint,GLint,GLint,GLint );
alias da_glRasterPos4s = void function( GLshort,GLshort,GLshort,GLshort );
alias da_glRasterPos2dv = void function( const( GLdouble )* );
alias da_glRasterPos2fv = void function( const( GLfloat )* );
alias da_glRasterPos2iv = void function( const( GLint )* );
alias da_glRasterPos2sv = void function( const( GLshort )* );
alias da_glRasterPos3dv = void function( const( GLdouble )* );
alias da_glRasterPos3fv = void function( const( GLfloat )* );
alias da_glRasterPos3iv = void function( const( GLint )* );
alias da_glRasterPos3sv = void function( const( GLshort )* );
alias da_glRasterPos4dv = void function( const( GLdouble )* );
alias da_glRasterPos4fv = void function( const( GLfloat )* );
alias da_glRasterPos4iv = void function( const( GLint )* );
alias da_glRasterPos4sv = void function( const( GLshort )* );*/

/*alias da_glRectd = void function( GLdouble,GLdouble,GLdouble,GLdouble );
alias da_glRectf = void function( GLfloat,GLfloat,GLfloat,GLfloat );
alias da_glRecti = void function( GLint,GLint,GLint,GLint );
alias da_glRects = void function( GLshort,GLshort,GLshort,GLshort );
alias da_glRectdv = void function( const( GLdouble )*, const( GLdouble )* );
alias da_glRectfv = void function( const( GLfloat )*, const( GLfloat )* );
alias da_glRectiv = void function( const( GLint )*, const( GLint )* );
alias da_glRectsv = void function( const( GLshort )*, const( GLshort )* );
alias da_glClipPlane = void function( GLenum,const( GLdouble )* );
alias da_glGetClipPlane = void function( GLenum,GLdouble* );
alias da_glShadeModel = void function( GLenum );
alias da_glLightf = void function( GLenum,GLenum,GLfloat );
alias da_glLighti = void function( GLenum,GLenum,GLint );
alias da_glLightfv = void function( GLenum,GLenum,const( GLfloat )* );
alias da_glLightiv = void function( GLenum,GLenum,const( GLint )* );
alias da_glGetLightfv = void function( GLenum,GLenum,GLfloat* );
alias da_glGetLightiv = void function( GLenum,GLenum,GLint* );
alias da_glLightModelf = void function( GLenum,GLfloat );
alias da_glLightModeli = void function( GLenum,GLint );
alias da_glLightModelfv = void function( GLenum,const( GLfloat )* );
alias da_glLightModeliv = void function( GLenum,const( GLint )* );
alias da_glMaterialf = void function( GLenum,GLenum,GLfloat );
alias da_glMateriali = void function( GLenum,GLenum,GLint );
alias da_glMaterialfv = void function( GLenum,GLenum,const( GLfloat )* );
alias da_glMaterialiv = void function( GLenum,GLenum,const( GLint )* );
alias da_glGetMaterialfv = void function( GLenum,GLenum,GLfloat* );
alias da_glGetMaterialiv = void function( GLenum,GLenum,GLint* );
alias da_glColorMaterial = void function( GLenum,GLenum );
alias da_glFogf = void function( GLenum,GLfloat );
alias da_glFogi = void function( GLenum,GLint );
alias da_glFogfv = void function( GLenum,const( GLfloat )* );
alias da_glFogiv = void function( GLenum,const( GLint )* );
alias da_glLineStipple = void function( GLint,GLushort );
alias da_glPolygonStipple = void function( const( GLubyte )* );
alias da_glGetPolygonStipple = void function( GLubyte* );
alias da_glTexGend = void function( GLenum,GLenum,GLdouble );
alias da_glTexGenf = void function( GLenum,GLenum,GLfloat );
alias da_glTexGeni = void function( GLenum,GLenum,GLint );
alias da_glTexGendv = void function( GLenum,GLenum,const( GLdouble )* );
alias da_glTexGenfv = void function( GLenum,GLenum,const( GLfloat )* );
alias da_glTexGeniv = void function( GLenum,GLenum,const( GLint )* );
alias da_glGetTexGendv = void function( GLenum,GLenum,GLdouble* );
alias da_glGetTexGenfv = void function( GLenum,GLenum,GLfloat* );
alias da_glGetTexGeniv = void function( GLenum,GLenum,GLint* );
alias da_glTexEnvf = void function( GLenum,GLenum,GLfloat );
alias da_glTexEnvi = void function( GLenum,GLenum,GLint );
alias da_glTexEnvfv = void function( GLenum,GLenum,const( GLfloat )* );
alias da_glTexEnviv = void function( GLenum,GLenum,const( GLint )* );
alias da_glGetTexEnvfv = void function( GLenum,GLenum,GLfloat* );
alias da_glGetTexEnviv = void function( GLenum,GLenum,GLint* );
alias da_glFeedbackBuffer = void function( GLsizei,GLenum,GLfloat* );
alias da_glPassThrough = void function( GLfloat );
alias da_glSelectBuffer = void function( GLsizei,GLuint* );
alias da_glInitNames = void function();
alias da_glLoadName = void function( GLuint );
alias da_glPushName = void function( GLuint );
alias da_glPopName = void function();
alias da_glRenderMode = GLint function( GLenum );
alias da_glClearAccum = void function( GLfloat,GLfloat,GLfloat,GLfloat );
alias da_glAccum = void function( GLenum,GLfloat );
alias da_glClearIndex = void function( GLfloat c );
alias da_glIndexMask = void function( GLuint );
alias da_glPushAttrib = void function( GLbitfield );
alias da_glPopAttrib = void function();
alias da_glMap1d = void function( GLenum,GLdouble,GLdouble,GLint,GLint,const( GLdouble )* );
alias da_glMap1f = void function( GLenum,GLfloat,GLfloat,GLint,GLint,const( GLfloat )* );
alias da_glMap2d = void function( GLenum,GLdouble,GLdouble,GLint,GLint,GLdouble,GLdouble,GLint,GLint,GLdouble* );
alias da_glMap2f = void function( GLenum,GLfloat,GLfloat,GLint,GLint,GLfloat,GLfloat,GLint,GLint,GLfloat* );
alias da_glGetMapdv = void function( GLenum,GLenum,GLdouble* );
alias da_glGetMapfv = void function( GLenum,GLenum,GLfloat* );
alias da_glGetMapiv = void function( GLenum,GLenum,GLint* );
alias da_glEvalCoord1d = void function( GLdouble );
alias da_glEvalCoord1f = void function( GLfloat );
alias da_glEvalCoord1dv = void function( const( GLdouble )* );
alias da_glEvalCoord1fv = void function( const( GLfloat )* );
alias da_glEvalCoord2d = void function( GLdouble,GLdouble );
alias da_glEvalCoord2f = void function( GLfloat,GLfloat );
alias da_glEvalCoord2dv = void function( const( GLdouble )* );
alias da_glEvalCoord2fv = void function( const( GLfloat )* );
alias da_glMapGrid1d = void function( GLint,GLdouble,GLdouble );
alias da_glMapGrid1f = void function( GLint,GLfloat,GLfloat );
alias da_glMapGrid2d = void function( GLint,GLdouble,GLdouble,GLint,GLdouble,GLdouble );
alias da_glMapGrid2f = void function( GLint,GLfloat,GLfloat,GLint,GLfloat,GLfloat );
alias da_glEvalPoint1 = void function( GLint );
alias da_glEvalPoint2 = void function( GLint,GLint );
alias da_glEvalMesh1 = void function( GLenum,GLint,GLint );
alias da_glEvalMesh2 = void function( GLenum,GLint,GLint,GLint,GLint );
alias da_glAlphaFunc = void function( GLenum,GLclampf );
alias da_glPixelZoom = void function( GLfloat,GLfloat );
alias da_glPixelTransferf = void function( GLenum,GLfloat );
alias da_glPixelTransferi = void function( GLenum,GLint );
alias da_glPixelMapfv = void function( GLenum,GLint,const( GLfloat )* );
alias da_glPixelMapuiv = void function( GLenum,GLint,const( GLuint )* );
alias da_glPixelMapusv = void function( GLenum,GLint,const( GLushort )* );
alias da_glGetPixelMapfv = void function( GLenum,GLfloat* );
alias da_glGetPixelMapuiv = void function( GLenum,GLuint* );
alias da_glGetPixelMapusv = void function( GLenum,GLushort* );
alias da_glDrawPixels = void function( GLsizei,GLsizei,GLenum,GLenum,const( void )* );
alias da_glCopyPixels = void function( GLint,GLint,GLsizei,GLsizei,GLenum );
alias da_glFrustum = void function( GLdouble,GLdouble,GLdouble,GLdouble,GLdouble,GLdouble );
alias da_glMatrixMode = void function( GLenum );
alias da_glOrtho = void function( GLdouble,GLdouble,GLdouble,GLdouble,GLdouble,GLdouble );
alias da_glPushMatrix = void function();
alias da_glPopMatrix = void function();
alias da_glLoadIdentity = void function();
alias da_glLoadMatrixd = void function( const( GLdouble )* );
alias da_glLoadMatrixf = void function( const( GLfloat )* );
alias da_glMultMatrixd = void function( const( GLdouble )* );
alias da_glMultMatrixf = void function( const( GLfloat )* );
alias da_glRotated = void function( GLdouble,GLdouble,GLdouble,GLdouble );
alias da_glRotatef = void function( GLfloat,GLfloat,GLfloat,GLfloat );
alias da_glScaled = void function( GLdouble,GLdouble,GLdouble );
alias da_glScalef = void function( GLfloat,GLfloat,GLfloat );
alias da_glTranslated = void function( GLdouble,GLdouble,GLdouble );
alias da_glTranslatef = void function( GLfloat,GLfloat,GLfloat );
alias da_glVertexPointer = void function( GLint,GLenum,GLsizei,const( void )* );
alias da_glNormalPointer = void function( GLenum,GLsizei,const( void )* );
alias da_glColorPointer = void function( GLint,GLenum,GLsizei,const( void )* );
alias da_glIndexPointer = void function( GLenum,GLsizei,const( void )* );
alias da_glTexCoordPointer = void function( GLint,GLenum,GLsizei,const( void )* );
alias da_glEdgeFlagPointer = void function( GLsizei,const( void )* );
alias da_glArrayElement = void function( GLint );
alias da_glInterleavedArrays = void function( GLenum,GLsizei,const( void )* );
alias da_glEnableClientState = void function( GLenum );
alias da_glDisableClientState = void function( GLenum );
alias da_glPrioritizeTextures = void function( GLsizei,const( GLuint )*,const( GLclampf )* );
alias da_glAreTexturesResident = GLboolean function( GLsizei,const( GLuint )*,GLboolean* );
alias da_glPushClientAttrib = void function( GLbitfield );
alias da_glPopClientAttrib = void function();*/