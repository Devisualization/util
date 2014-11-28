module source.opengl.devisualization.util.opengl.texture;
import gl = derelict.opengl3.gl3;
import devisualization.util.opengl.function_wrappers;
public import devisualization.util.opengl.function_wrappers : InternalFormat, BindTextureTarget, PixelFormat;
import devisualization.image;
import devisualization.image.color;

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

        int id() {
            return id_;
        }
    }
    
    private {
        void setup() {
            glPixelStore(PixelStoreMode.UnpackingAlignment, 1);
            glGenTextures(id_);
            bind();
            update();
            glPixelStore(PixelStoreMode.UnpackingAlignment, 4);
        }
        
        void update() {
            glTexImage2D(BindTextureTarget.Texture2D, 0, InternalFormat.RGBA, cast(uint)image_.width, cast(uint)image_.height, PixelFormat.RGBA, PixelDataType.UnsignedByte, cast(void[])ubyteRawColor(image.rgba.allPixels)[0]);
            gl.glGenerateMipmap(BindTextureTarget.Texture2D);
        }
    }
}