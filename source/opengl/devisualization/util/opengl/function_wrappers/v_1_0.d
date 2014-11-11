module devisualization.util.opengl.function_wrappers.v_1_0;
import gl = derelict.opengl3.gl;
import gldepcnst = derelict.opengl3.deprecatedConstants;

// no need to polute name space any further when its args don't change
public import derelict.opengl3.gl : glFlush, glFinish, glScissor, glLineWidth, glPointSize, glClearColor, glClearStencil, glStencilMask, glDepthMask;

enum InternalFormat {
    DepthComponent = gl.GL_DEPTH_COMPONENT,
    DepthStencil = gl.GL_DEPTH_STENCIL,
    Red = gl.GL_RED,
    RG = gl.GL_RG,
    RGB = gl.GL_RGB,
    RGBA = gl.GL_RGBA,
    
    RGB8 = gl.GL_RGB8
}

enum EnableFunc {
    Blend = gl.GL_BLEND,
    ClipDistance = gl.GL_CLIP_DISTANCE0,
    ColorLogicOp = gl.GL_COLOR_LOGIC_OP,
    CullFace = gl.GL_CULL_FACE,
    DebugOutput = gl.GL_DEBUG_OUTPUT,
    DebugOutputSynchroonous = gl.GL_DEBUG_OUTPUT_SYNCHRONOUS,
    DepthClamp = gl.GL_DEPTH_CLAMP,
    DepthTest = gl.GL_DEPTH_TEST,
    Dither = gl.GL_DITHER,
    FrameBufferSRGB = gl.GL_FRAMEBUFFER_SRGB,
    LineSmooth = gl.GL_LINE_SMOOTH,
    MultiSample = gl.GL_MULTISAMPLE,
    PolygonOffsetFill = gl.GL_POLYGON_OFFSET_FILL,
    PolygonOffsetLine = gl.GL_POLYGON_OFFSET_LINE,
    PolygonOffsetPoint = gl.GL_POLYGON_OFFSET_POINT,
    PolygonSmooth = gl.GL_POLYGON_SMOOTH,
    PrimitiveRestart = gl.GL_PRIMITIVE_RESTART,
    PrimitiveRestartFixedIndex = gl.GL_PRIMITIVE_RESTART_FIXED_INDEX,
    RasterizerDiscard = gl.GL_RASTERIZER_DISCARD,
    SampleAlphaToCoverage = gl.GL_SAMPLE_ALPHA_TO_COVERAGE,
    SampleAlphaToOne = gl.GL_SAMPLE_ALPHA_TO_ONE,
    SampleCoverage = gl.GL_SAMPLE_COVERAGE,
    SampleShading = gl.GL_SAMPLE_SHADING,
    SampleMask = gl.GL_SAMPLE_MASK,
    ScissorTest = gl.GL_SCISSOR_TEST,
    StencilTest = gl.GL_STENCIL_TEST,
    TextureCubeMapSeamless = gl.GL_TEXTURE_CUBE_MAP_SEAMLESS,
    ProgramPointSize = gl.GL_PROGRAM_POINT_SIZE
}

enum BlendFactors {
    Zero = gl.GL_ZERO,
    One = gl.GL_ONE,
    SrcColor = gl.GL_SRC_COLOR,
    OneMinusSrcColor = gl.GL_ONE_MINUS_SRC_COLOR,
    DstColor = gl.GL_DST_COLOR,
    OneMinusDstColor = gl.GL_ONE_MINUS_DST_COLOR,
    SrcAlpha = gl.GL_SRC_ALPHA,
    OneMinusSrcAlpha = gl.GL_ONE_MINUS_SRC_ALPHA,
    DstAlpha = gl.GL_DST_ALPHA,
    OneMinusDstAlpha = gl.GL_ONE_MINUS_DST_ALPHA,
    ConstantColor = gldepcnst.GL_CONSTANT_COLOR,
    OneMinusConstantColor = gldepcnst.GL_ONE_MINUS_CONSTANT_COLOR,
    ConstantAlpha = gldepcnst.GL_CONSTANT_ALPHA,
    OneMinusConstantAlpha = gldepcnst.GL_ONE_MINUS_CONSTANT_ALPHA,
    SrcAlphaSaturate = gl.GL_SRC_ALPHA_SATURATE,
    Src2Color = gl.GL_SRC1_COLOR
}

enum BindTextureTarget {
    Texture1D = gl.GL_TEXTURE_1D,
    Texture2D = gl.GL_TEXTURE_2D,
    Texture3D = gl.GL_TEXTURE_3D,
    Texture1DArray = gl.GL_TEXTURE_1D_ARRAY,
    Texture2DArray = gl.GL_TEXTURE_2D_ARRAY,
    TextureRectangle = gl.GL_TEXTURE_RECTANGLE,
    TextureCubeMap = gl.GL_TEXTURE_CUBE_MAP,
    TextureCubeMapArray = gl.GL_TEXTURE_CUBE_MAP_ARRAY,
    TextureBuffer = gl.GL_TEXTURE_BUFFER,
    Texture2DMultiSample = gl.GL_TEXTURE_2D_MULTISAMPLE,
    Texture2DMultiSampleArray = gl.GL_TEXTURE_2D_MULTISAMPLE_ARRAY
}

enum PixelFormat {
    Red = gl.GL_RED,
    RG = gl.GL_RG,
    RGB = gl.GL_RGB,
    BGR = gl.GL_BGR,
    RGBA = gl.GL_RGBA,
    BGRA = gl.GL_BGRA,
    RedInteger = gl.GL_RED_INTEGER,
    RG_Integer = gl.GL_RG_INTEGER,
    RGB_Integer = gl.GL_RGB_INTEGER,
    BGR_Integer = gl.GL_BGR_INTEGER,
    RGBA_Integer = gl.GL_RGBA_INTEGER,
    BGRA_Integer = gl.GL_BGRA_INTEGER,
    StencilIndex = gl.GL_STENCIL_INDEX,
    DepthComponent = gl.GL_DEPTH_COMPONENT,
    DepthStencil = gl.GL_DEPTH_STENCIL
}

enum PixelDataType {
    UByte = gl.GL_UNSIGNED_BYTE,
    Byte = gl.GL_BYTE,
    UShort = gl.GL_UNSIGNED_SHORT,
    Short = gl.GL_SHORT,
    UInt = gl.GL_UNSIGNED_INT,
    Int = gl.GL_INT,
    Float = gl.GL_FLOAT,
    UByte332 = gl.GL_UNSIGNED_BYTE_3_3_2,
    UByte233Rev = gl.GL_UNSIGNED_BYTE_2_3_3_REV,
    UShort565 = gl.GL_UNSIGNED_SHORT_5_6_5,
    UShort565Rev = gl.GL_UNSIGNED_SHORT_5_6_5,
    UShort4444 = gl.GL_UNSIGNED_SHORT_4_4_4_4,
    UShort4444Rev = gl.GL_UNSIGNED_SHORT_4_4_4_4_REV,
    UShort5551 = gl.GL_UNSIGNED_SHORT_5_5_5_1,
    UShort1555Rev = gl.GL_UNSIGNED_SHORT_1_5_5_5_REV,
    UInt8888 = gl.GL_UNSIGNED_INT_8_8_8_8,
    UInt8888Rev = gl.GL_UNSIGNED_INT_8_8_8_8_REV,
    UInt101010102 = gl.GL_UNSIGNED_INT_10_10_10_2,
    UINT2101010REV = gl.GL_UNSIGNED_INT_2_10_10_10_REV
}

enum Face {
    Front = gl.GL_FRONT,
    Back = gl.GL_BACK,
    FrontAndBack = gl.GL_FRONT_AND_BACK
}

enum HintMode {
    Fastest = gl.GL_FASTEST,
    Nicest = gl.GL_NICEST,
    DontCare = gl.GL_DONT_CARE
}

enum ClockOrientation {
    ClockWise = gl.GL_CW,
    CounterClockWise = gl.GL_CCW
}

enum PolygonMode {
    Point = gl.GL_POINT,
    Line = gl.GL_LINE,
    FILL = gl.GL_FILL
}

enum TextureParameterTarget {
    Texture1D = gl.GL_TEXTURE_1D,
    Texture2D = gl.GL_TEXTURE_2D,
    Texture3D = gl.GL_TEXTURE_3D,
    Texture1DArray = gl.GL_TEXTURE_1D_ARRAY,
    Texture2DArray = gl.GL_TEXTURE_2D_ARRAY,
    TextureRectangle = gl.GL_TEXTURE_RECTANGLE,
    TextureCubeMap = gl.GL_TEXTURE_CUBE_MAP
}

enum TextureParameterName {
    BaseLevel = gl.GL_TEXTURE_BASE_LEVEL,
    CompareFunc = gl.GL_TEXTURE_COMPARE_FUNC,
    CompareMode = gl.GL_TEXTURE_COMPARE_MODE,
    LODBias = gl.GL_TEXTURE_LOD_BIAS,
    MinFilter = gl.GL_TEXTURE_MIN_FILTER,
    MagFilter = gl.GL_TEXTURE_MAG_FILTER,
    MinLOD = gl.GL_TEXTURE_MIN_LOD,
    MaxLOD = gl.GL_TEXTURE_MAX_LOD,
    MaxLevel = gl.GL_TEXTURE_MAX_LEVEL,
    SwizzleR = gl.GL_TEXTURE_SWIZZLE_R,
    SwizzleG = gl.GL_TEXTURE_SWIZZLE_G,
    SwizzleB = gl.GL_TEXTURE_SWIZZLE_B,
    SwizzleA = gl.GL_TEXTURE_SWIZZLE_A,
    WrapS = gl.GL_TEXTURE_WRAP_S,
    WrapT = gl.GL_TEXTURE_WRAP_T,
    WrapR = gl.GL_TEXTURE_WRAP_R
}

enum TextureImage1D {
    Texture1D = gl.GL_TEXTURE_1D,
    ProxyTexture1D = gl.GL_PROXY_TEXTURE_1D
}

enum TextureImage2D {
    Texture2D = gl.GL_TEXTURE_2D,
    ProxyTexture2D = gl.GL_PROXY_TEXTURE_2D,
    Texture1DArray = gl.GL_TEXTURE_1D_ARRAY,
    ProxyTexture1DArray = gl.GL_PROXY_TEXTURE_1D_ARRAY,
    TextureRectangle = gl.GL_TEXTURE_RECTANGLE,
    ProxyTextureRectangle = gl.GL_PROXY_TEXTURE_RECTANGLE,
    TextureCubeMapPositiveX = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    TextureCubeMapNegativeX = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    TextureCubeMapPositiveY = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    TextureCubeMapNegativeY = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    TextureCubeMapPositiveZ = gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    TextureCubeMapNegativeZ = gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    ProxyTextureCubeMap = gl.GL_PROXY_TEXTURE_CUBE_MAP
}

enum DrawBufferType {
    None = gldepcnst.GL_NONE,
    FrontLeft = gl.GL_FRONT_LEFT,
    FrontRight = gl.GL_FRONT_RIGHT,
    BackLeft = gl.GL_BACK_LEFT,
    BackRight = gl.GL_BACK_RIGHT,
    Front = gl.GL_FRONT,
    Back = gl.GL_BACK,
    Left = gl.GL_LEFT,
    Right = gl.GL_RIGHT,
    FrontAndBack = gl.GL_FRONT_AND_BACK
}

void glClear(bool buffer = false, bool depth = false, bool stencil = false) {
    gl.glClear((buffer ? gl.GL_COLOR_BUFFER_BIT : 0) | (depth ? gl.GL_DEPTH_BUFFER_BIT : 0) | (stencil ? gl.GL_STENCIL_BUFFER_BIT : 0));
}

void glTexImage2D(BindTextureTarget target, int level, InternalFormat internalFormat, int width, int height, PixelFormat format, PixelDataType type, void[] data) {
    gl.glTexImage2D(cast(gl.GLenum)target, level, cast(gl.GLenum)internalFormat, width, height, 0, cast(gl.GLenum)format, cast(gl.GLenum)type, data.ptr);
}

void glCullFace(Face face = Face.Back) {
    gl.glCullFace(cast(gl.GLenum)face);
}

void glFrontFace(ClockOrientation orientation = ClockOrientation.CounterClockWise) {
    gl.glFrontFace(cast(gl.GLenum)orientation);
}

void glHint(HintMode mode) {
    gl.glHint(gl.GL_GENERATE_MIPMAP_HINT, cast(gl.GLenum)mode);
}

void glPolygonMode(Face face, PolygonMode mode) {
    gl.glPolygonMode(cast(gl.GLenum)face, cast(gl.GLenum)mode);
}

void glTexParameter(TextureParameterTarget target,
                     TextureParameterName pname,
                     float param) {
    gl.glTexParameterf(target, pname, param);
}

void glTexParameter(TextureParameterTarget target,
                    TextureParameterName pname,
                    int param) {
    gl.glTexParameteri(target, pname, param);
}

void glTexParameter(TextureParameterTarget target,
                    TextureParameterName pname,
                    float[] param) {
    gl.glTexParameterfv(target, pname, param.ptr);
}

void glTexParameter(TextureParameterTarget target,
                    TextureParameterName pname,
                    int[] param) {
    gl.glTexParameteriv(target, pname, param.ptr);
}

void glTexParameterI(TextureParameterTarget target,
                    TextureParameterName pname,
                    int[] param) {
    gl.glTexParameterIiv(target, pname, param.ptr);
}

void glTexParameterI(TextureParameterTarget target,
                    TextureParameterName pname,
                    uint[] param) {
    gl.glTexParameterIuiv(target, pname, param.ptr);
}

void glTexImage(TextureImage1D target, int level, InternalFormat internalFormat, int width, int border, PixelFormat format, PixelDataType type, void[] data) {
    gl.glTexImage1D(target, level, internalFormat, width, border, format, type, data.ptr);
}

void glTexImage(TextureImage2D target, int level, InternalFormat internalFormat, int width, int height, int border, PixelFormat format, PixelDataType type, void[] data) {
    gl.glTexImage2D(target, level, internalFormat, width, height, border, format, type, data.ptr);
}

void glDrawBuffer(DrawBufferType type) {
    gl.glDrawBuffer(type);
}

void glClearDepth(int value) {
    gl.glClearDepth(value);
}

void glClearDepth(float value) {
    gl.glClearDepthf(value);
}

void glColorMask(bool red, bool green, bool blue, bool alpha) {
    gl.glColorMask(red, green, blue, alpha);
}

void glColorMask(uint buf, bool red, bool green, bool blue, bool alpha) {
    gl.glColorMaski(buf, red, green, blue, alpha);
}

void glEnable(EnableFunc func) {
    gl.glEnable(cast(gl.GLenum)func);
}

void glDisable(EnableFunc func) {
    gl.glDisable(cast(gl.GLenum)func);
}

void glBlendFunc(BlendFactors sfactor, BlendFactors dfactor) {
    gl.glBlendFunc(cast(gl.GLenum)sfactor, cast(gl.GLenum)dfactor);
}

void glBlendFunci(uint buf, BlendFactors sfactor, BlendFactors dfactor) {
    gl.glBlendFunci(buf, cast(gl.GLenum)sfactor, cast(gl.GLenum)dfactor);
}

/*bindFunc(cast(void**)&glLogicOp, "glLogicOp");
bindFunc(cast(void**)&glStencilFunc, "glStencilFunc");
bindFunc(cast(void**)&glStencilOp, "glStencilOp");
bindFunc(cast(void**)&glDepthFunc, "glDepthFunc");
bindFunc(cast(void**)&glPixelStoref, "glPixelStoref");
bindFunc(cast(void**)&glPixelStorei, "glPixelStorei");
bindFunc(cast(void**)&glReadBuffer, "glReadBuffer");
bindFunc(cast(void**)&glReadPixels, "glReadPixels");
bindFunc(cast(void**)&glGetBooleanv, "glGetBooleanv");
bindFunc(cast(void**)&glGetDoublev, "glGetDoublev");
bindFunc(cast(void**)&glGetError, "glGetError");
bindFunc(cast(void**)&glGetFloatv, "glGetFloatv");
bindFunc(cast(void**)&glGetIntegerv, "glGetIntegerv");
bindFunc(cast(void**)&glGetString, "glGetString");
bindFunc(cast(void**)&glGetTexImage, "glGetTexImage");
bindFunc(cast(void**)&glGetTexParameterfv, "glGetTexParameterfv");
bindFunc(cast(void**)&glGetTexParameteriv, "glGetTexParameteriv");
bindFunc(cast(void**)&glGetTexLevelParameterfv, "glGetTexLevelParameterfv");
bindFunc(cast(void**)&glGetTexLevelParameteriv, "glGetTexLevelParameteriv");
bindFunc(cast(void**)&glIsEnabled, "glIsEnabled");
bindFunc(cast(void**)&glDepthRange, "glDepthRange");
bindFunc(cast(void**)&glViewport, "glViewport");*/