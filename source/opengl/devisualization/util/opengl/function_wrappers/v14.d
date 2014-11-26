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
module devisualization.util.opengl.function_wrappers.v14;
import gl = derelict.opengl3.gl;
public import devisualization.util.opengl.function_wrappers.v10 : BlendFactors;
public import devisualization.util.opengl.function_wrappers.v11 : Primitives;

enum PointParamaterNames {
    FadeThresholdSize = gl.GL_POINT_FADE_THRESHOLD_SIZE,
    SpriteCoordOrigin = gl.GL_POINT_SPRITE_COORD_ORIGIN
}

void glBlendFuncSeparate(BlendFactors srcRGB, BlendFactors dstRGB, BlendFactors srcAlpha, BlendFactors dstAlpha) {
    gl.glBlendFuncSeparate(cast(gl.GLenum)srcRGB, cast(gl.GLenum)dstRGB, cast(gl.GLenum)srcAlpha, cast(gl.GLenum)dstAlpha);
}

void glMultiDrawArrays(Primitives mode, int[] first, int[] count)
in {
    assert(first.length == count.length);
} body {
    gl.glMultiDrawArrays(cast(gl.GLenum)mode, first.ptr, count.ptr, cast(uint)first.length);
}

void glMultiDrawElements(Primitives mode, int[] count, ubyte[] indices) {
    gl.glMultiDrawElements(cast(gl.GLenum)mode, count.ptr, gl.GL_UNSIGNED_BYTE, indices.ptr, cast(uint)indices.length);
}

void glMultiDrawElements(Primitives mode, int[] count, ushort[] indices) {
    gl.glMultiDrawElements(cast(gl.GLenum)mode, count.ptr, gl.GL_UNSIGNED_SHORT, indices.ptr, cast(uint)indices.length);
}

void glMultiDrawElements(Primitives mode, int[] count, uint[] indices) {
    gl.glMultiDrawElements(cast(gl.GLenum)mode, count.ptr, gl.GL_UNSIGNED_INT, indices.ptr, cast(uint)indices.length);
}

void glPointParameterf(PointParamaterNames pname, float param) {
    gl.glPointParameterf(cast(gl.GLenum)pname, param);
}

void glPointParameterfv(PointParamaterNames pname, float[] params) {
    gl.glPointParameterfv(cast(gl.GLenum)pname, params.ptr);
}

void glPointParameteri(PointParamaterNames pname, int param) {
    gl.glPointParameterf(cast(gl.GLenum)pname, param);
}

void glPointParameteriv(PointParamaterNames pname, int[] params) {
    gl.glPointParameteriv(cast(gl.GLenum)pname, params.ptr);
}