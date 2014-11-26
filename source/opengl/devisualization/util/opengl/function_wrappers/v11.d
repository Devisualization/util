/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2014 Devisualization (Richard Andrew Cattermole)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
module devisualization.util.opengl.function_wrappers.v11;
import gl = derelict.opengl3.gl;
public import devisualization.util.opengl.function_wrappers.v10 : BindTextureTarget, InternalFormat;

// no need to polute name space any further when its args don't change
public import derelict.opengl3.gl : glPolygonOffset, glIsTexture;

enum Primitives {
    Points = gl.GL_POINTS,
    LineStrip = gl.GL_LINE_STRIP,
    LineLoop = gl.GL_LINE_LOOP,
    Lines = gl.GL_LINES,
    LineStripAdjacency = gl.GL_LINE_STRIP_ADJACENCY,
    LinesAdjacency = gl.GL_LINES_ADJACENCY,
    TriangleStrip = gl.GL_TRIANGLE_STRIP,
    TriangleFan = gl.GL_TRIANGLE_FAN,
    Triangles = gl.GL_TRIANGLES,
    TriangleStripAdjacency = gl.GL_TRIANGLE_STRIP_ADJACENCY,
    TrianglesAdjacency = gl.GL_TRIANGLES_ADJACENCY,
    Patches = gl.GL_PATCHES
}

enum CompressedTextureTargets2D {
    Texture2D = gl.GL_TEXTURE_2D,
    TextureCubeMapPositiveX = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    TextureCubeMapNegativeX = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    TextureCubeMapPositiveY = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    TextureCubeMapNegativeY = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    TextureCubeMapPositiveZ = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    TextureCubeMapNegativeZ = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z
}

void glDrawArrays(Primitives mode, int first, int count) {
    gl.glDrawArrays(cast(gl.GLenum)mode, first, count);
}

void glDrawElements(Primitives mode, ubyte[] indices) {
    gl.glDrawElements(cast(gl.GLenum)mode, cast(uint)indices.length, gl.GL_UNSIGNED_BYTE, cast(void*)indices.ptr);
}

void glDrawElements(Primitives mode, ushort[] indices) {
    gl.glDrawElements(cast(gl.GLenum)mode, cast(uint)indices.length, gl.GL_UNSIGNED_SHORT, cast(void*)indices.ptr);
}

void glDrawElements(Primitives mode, uint[] indices) {
    gl.glDrawElements(cast(gl.GLenum)mode, cast(uint)indices.length, gl.GL_UNSIGNED_INT, cast(void*)indices.ptr);
}

void glCopyTexImage1D(int level, InternalFormat internalFormat, int x, int y, int width) {
    gl.glCopyTexImage1D(gl.GL_TEXTURE_1D, level, cast(gl.GLenum)internalFormat, x, y, width, 0);
}

void glCopyTexImage2D(CompressedTextureTargets2D target, int level, InternalFormat internalFormat, int x, int y, int width, int height) {
    gl.glCopyTexImage2D(cast(gl.GLenum)target, level, cast(gl.GLenum)internalFormat, x, y, width, height, 0);
}

void glCopyTexSubImage1D(int level, int xoffset, int x, int y, int width) {
    gl.glCopyTexSubImage1D(gl.GL_TEXTURE_1D, level, xoffset, x, y, width);
}

void glCopyTexSubImage2D(CompressedTextureTargets2D target, int level, int xoffset, int yoffset, int x, int y, int width, int height) {
    gl.glCopyTexSubImage2D(cast(gl.GLenum)target, level, xoffset, yoffset, x, y, width, height);
}

void glBindTexture(BindTextureTarget target, uint texture) {
    gl.glBindTexture(cast(gl.GLenum)target, texture);
}

void glDeleteTextures(uint[] textures) {
    gl.glDeleteTextures(cast(uint)textures.length, textures.ptr);
}

void glDeleteTextures(uint texture) {
    gl.glDeleteTextures(1, &texture);
}

uint glGenTextures() {
    uint ret;
    gl.glGenTextures(1, &ret);
    return ret;
}

uint[] glGenTextures(int n) {
    uint[] ret;
    gl.glGenTextures(n, ret.ptr);
    return ret;
}