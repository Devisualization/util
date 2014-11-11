﻿/*
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
module devisualization.util.opengl.function_wrappers.v_1_3;
import gl = derelict.opengl3.gl;
public import devisualization.util.opengl.function_wrappers.v_1_0 : InternalFormat;
public import devisualization.util.opengl.function_wrappers.v_1_1 : CompressedTextureTargets2D;
public import devisualization.util.opengl.function_wrappers.v_1_2 : TextureTargets;

enum TextureTargets2D {
    Texture2D = gl.GL_TEXTURE_2D,
    ProxyTexture2D = gl.GL_PROXY_TEXTURE_2D,
    Texture1DArray = gl.GL_TEXTURE_1D_ARRAY,
    ProxyTexture1DArray = gl.GL_PROXY_TEXTURE_1D_ARRAY,
    TextureCubeMapPositiveX = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    TextureCubeMapNegativeX = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    TextureCubeMapPositiveY = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    TextureCubeMapNegativeY = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    TextureCubeMapPositiveZ = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    TextureCubeMapNegativeZ = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    ProxyTextureCubeMap = gl.GL_PROXY_TEXTURE_CUBE_MAP
}

enum TextureTargets1D {
    Texture1D = gl.GL_TEXTURE_1D,
    ProxyTexture1D = gl.GL_PROXY_TEXTURE_1D
}

enum CompressedTextureTargets {
    Texture1D = gl.GL_TEXTURE_1D,
    Texture2D = gl.GL_TEXTURE_2D,
    Texture3D = gl.GL_TEXTURE_3D,
    TextureCubeMapPositiveX = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    TextureCubeMapNegativeX = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    TextureCubeMapPositiveY = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    TextureCubeMapnegativeY = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    TextureCubeMapPositiveZ = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    TextureCubeMapNegativeZ = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z
}

void glActiveTexture(uint texture = gl.GL_TEXTURE0)
in {
    assert(texture < gl.GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS);
} body {
    gl.glActiveTexture(texture);
}

void glSampleCoverage(float value, bool invert)
in {
    assert(value <= 1);
    assert(value >= 0);
} body {
    gl.glSampleCoverage(value, cast(gl.GLboolean)invert);
}

void glCompressedTexImage3D(TextureTargets target, int level, InternalFormat internalFormat, int width, int height, int depth, void[] data)
in {
    assert(level >= 0);
} body {
    gl.glCompressedTexImage3D(cast(gl.GLenum)target, level, cast(gl.GLenum)internalFormat, width, height, depth, 0, cast(uint)data.length, data.ptr);
}

void glCompressedTexImage2D(TextureTargets2D target, int level, InternalFormat internalFormat, int width, int height, void[] data)
in {
    assert(level >= 0);
} body {
    gl.glCompressedTexImage2D(cast(gl.GLenum)target, level, cast(gl.GLenum)internalFormat, width, height, 0, cast(uint)data.length, data.ptr);
}

void glCompressedTexImage1D(TextureTargets1D target, int level, InternalFormat internalFormat, int width, void[] data)
in {
    assert(level >= 0);
} body {
    gl.glCompressedTexImage1D(cast(gl.GLenum)target, level, cast(gl.GLenum)internalFormat, width, 0, cast(uint)data.length, data.ptr);
}

void glCompressedTexSubImage3D(int level, int xoffset, int yoffset, int zoffset, int width, int height, int depth, InternalFormat internalFormat, void[] data)
in {
    assert(level >= 0);
} body {
    gl.glCompressedTexSubImage3D(gl.GL_TEXTURE_3D, level, xoffset, yoffset, zoffset, width, height, depth, internalFormat, cast(uint)data.length, data.ptr);
}

void glCompressedTexSubImage2D(CompressedTextureTargets2D target, int level, int xoffset, int yoffset, int width, int height, InternalFormat internalFormat, void[] data)
in {
    assert(level >= 0);
} body {
    gl.glCompressedTexSubImage2D(cast(gl.GLenum)target, level, xoffset, yoffset, width, height, internalFormat, cast(uint)data.length, data.ptr);
}

void glCompressedTexSubImage1D(int level, int xoffset, int width, InternalFormat internalFormat, void[] data)
in {
    assert(level >= 0);
} body {
    gl.glCompressedTexSubImage1D(gl.GL_TEXTURE_1D, level, xoffset, width, internalFormat, cast(uint)data.length, data.ptr);
}

void[] glGetCompressedTexImage(CompressedTextureTargets target, int lod) {
    void[] ret;
    gl.glGetCompressedTexImage(cast(gl.GLenum)target, lod, ret.ptr);
    return ret;
}