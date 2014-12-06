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
module devisualization.util.opengl.texture;
import devisualization.util.opengl.function_wrappers;
import devisualization.image;
import devisualization.image.color;
public import devisualization.util.opengl.function_wrappers : InternalFormat, BindTextureTarget, PixelFormat;
import glINCOMPLETE = derelict.opengl3.gl3;

struct TextureImage {
    private {
        Image image_;
        uint id_;
    }

    this(Image image) {
        image_ = image;
        setup();
    }
    
    ~this() {
        // destroy obj
        glDeleteTextures(id_);
    }
    
    uint opCast(T : uint)() {
        return cast(uint)id_;
    }
    
    void bind(uint activeTexture = 0) {
        glActiveTexture(activeTexture);
        glBindTexture(BindTextureTarget.Texture2D, id_);
        glTexParameter(TextureParameterTarget.Texture2D, TextureParameterName.MinFilter, gl.GL_NEAREST_MIPMAP_NEAREST);
        glTexParameter(TextureParameterTarget.Texture2D, TextureParameterName.MagFilter, gl.GL_NEAREST);
    }

    void wrapping(TextureWrapping s) {
        int restoreId = glGetInteger(GetValueNames.TextureBinding2D);
        
        glBindTexture(BindTextureTarget.Texture2D, id_);
        glTexParameter(TextureParameterTarget.Texture2D, TextureParameterName.WrapS, s);
        
        glBindTexture(BindTextureTarget.Texture2D, restoreId);
    }
    
    void wrapping(TextureWrapping s, TextureWrapping t) {
        int restoreId = glGetInteger(GetValueNames.TextureBinding2D);
        
        glBindTexture(BindTextureTarget.Texture2D, id_);
        glTexParameter(TextureParameterTarget.Texture2D, TextureParameterName.WrapS, s);
        glTexParameter(TextureParameterTarget.Texture2D, TextureParameterName.WrapT, t);
        
        glBindTexture(BindTextureTarget.Texture2D, restoreId);
    }
    
    void wrapping(TextureWrapping s, TextureWrapping t, TextureWrapping r) {
        int restoreId = glGetInteger(GetValueNames.TextureBinding2D);
        
        glBindTexture(BindTextureTarget.Texture2D, id_);
        glTexParameter(TextureParameterTarget.Texture2D, TextureParameterName.WrapS, s);
        glTexParameter(TextureParameterTarget.Texture2D, TextureParameterName.WrapT, t);
        glTexParameter(TextureParameterTarget.Texture2D, TextureParameterName.WrapR, r);
        
        glBindTexture(BindTextureTarget.Texture2D, restoreId);
    }

    void filters(TextureFilter min, TextureFilter mag) {
        int restoreId = glGetInteger(GetValueNames.TextureBinding2D);
        
        glBindTexture(BindTextureTarget.Texture2D, id_);
        glTexParameter(TextureParameterTarget.Texture2D, TextureParameterName.MinFilter, min);
        glTexParameter(TextureParameterTarget.Texture2D, TextureParameterName.MagFilter, mag);
        
        glBindTexture(BindTextureTarget.Texture2D, restoreId);
    }

    void borderColor(ref Color_RGBA color) {
        int restoreId = glGetInteger(GetValueNames.TextureBinding2D);

        glBindTexture(BindTextureTarget.Texture2D, id_);
        glTexParameter(TextureParameterTarget.Texture2D, TextureParameterName.BorderColor, cast(int[])color.ubytes);

        glBindTexture(BindTextureTarget.Texture2D, restoreId);
    }
    
    @property {
        Image image() {
            return image_;
        }

        void image(Image value) {
            image_ = value;
            setup();
        }
    }
    
    private {
        void setup() {
            glGenTextures(id_);
            bind();
            update();
        }
        
        void update() {
            glPixelStore(PixelStoreMode.UnpackingAlignment, 1);
            glTexImage2D(BindTextureTarget.Texture2D, 0, InternalFormat.RGBA, cast(uint)image_.width, cast(uint)image_.height, PixelFormat.RGBA, PixelDataType.UnsignedByte, *cast(void[]*)ubyteRawColor(image.rgba.allPixels)[0].ptr);
            glINCOMPLETE.glGenerateMipmap(BindTextureTarget.Texture2D);
            glPixelStore(PixelStoreMode.UnpackingAlignment, 4);
        }
    }
}