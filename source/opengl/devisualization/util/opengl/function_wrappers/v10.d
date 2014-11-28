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
module devisualization.util.opengl.function_wrappers.v10;
import gl = derelict.opengl3.gl;
import gldepcnst = derelict.opengl3.deprecatedConstants;

// no need to polute name space any further when its args don't change
public import derelict.opengl3.gl : glFlush, glFinish, glScissor, glLineWidth, glPointSize, glClearColor, glClearStencil, glStencilMask, glDepthMask, glViewport;

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
    RGInteger = gl.GL_RG_INTEGER,
    RGBInteger = gl.GL_RGB_INTEGER,
    BGRInteger = gl.GL_BGR_INTEGER,
    RGBAInteger = gl.GL_RGBA_INTEGER,
    BGRAInteger = gl.GL_BGRA_INTEGER,
    StencilIndex = gl.GL_STENCIL_INDEX,
    DepthComponent = gl.GL_DEPTH_COMPONENT,
    DepthStencil = gl.GL_DEPTH_STENCIL
}

enum PixelDataType {
    UnsignedByte = gl.GL_UNSIGNED_BYTE,
    Byte = gl.GL_BYTE,
    UnsignedShort = gl.GL_UNSIGNED_SHORT,
    Short = gl.GL_SHORT,
    UnsignedInt = gl.GL_UNSIGNED_INT,
    Int = gl.GL_INT,
    Float = gl.GL_FLOAT,
    UnsignedByte332 = gl.GL_UNSIGNED_BYTE_3_3_2,
    UnsignedByte233Rev = gl.GL_UNSIGNED_BYTE_2_3_3_REV,
    UnsignedShort565 = gl.GL_UNSIGNED_SHORT_5_6_5,
    UnsignedShort565Rev = gl.GL_UNSIGNED_SHORT_5_6_5,
    UnsignedShort4444 = gl.GL_UNSIGNED_SHORT_4_4_4_4,
    UnsignedShort4444Rev = gl.GL_UNSIGNED_SHORT_4_4_4_4_REV,
    UnsignedShort5551 = gl.GL_UNSIGNED_SHORT_5_5_5_1,
    UnsignedShort1555Rev = gl.GL_UNSIGNED_SHORT_1_5_5_5_REV,
    UnsignedInt8888 = gl.GL_UNSIGNED_INT_8_8_8_8,
    UnsignedInt8888Rev = gl.GL_UNSIGNED_INT_8_8_8_8_REV,
    UnsignedInt101010102 = gl.GL_UNSIGNED_INT_10_10_10_2,
    UnsignedInt2101010REV = gl.GL_UNSIGNED_INT_2_10_10_10_REV
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
    WrapR = gl.GL_TEXTURE_WRAP_R,

    BorderColor = gl.GL_TEXTURE_BORDER_COLOR,
    SwizzleRGBA = gl.GL_TEXTURE_SWIZZLE_RGBA
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

enum LogicOperators {
    Clear = gl.GL_CLEAR,
    Set = gl.GL_SET,
    Copy = gl.GL_COPY,
    CopyInverted = gl.GL_COPY_INVERTED,
    Noop = gl.GL_NOOP,
    Invert = gl.GL_INVERT,
    And = gl.GL_AND,
    Nand = gl.GL_NAND,
    Or = gl.GL_OR,
    Nor = gl.GL_NOR,
    Xor = gl.GL_XOR,
    Equiv = gl.GL_EQUIV,
    AndReverse = gl.GL_AND_REVERSE,
    AndInverted = gl.GL_AND_INVERTED,
    OrReverse = gl.GL_OR_REVERSE,
    OrInverted = gl.GL_OR_INVERTED
}

enum LogicalComparison {
    Never = gl.GL_NEVER,
    Less = gl.GL_LESS,
    LessOrEqual = gl.GL_LEQUAL,
    Greater = gl.GL_GREATER,
    Equal = gl.GL_EQUAL,
    NotEqual = gl.GL_NOTEQUAL,
    Always = gl.GL_ALWAYS
}

enum StencilOperators {
    Keep = gl.GL_KEEP,
    Zero = gl.GL_ZERO,
    Replace = gl.GL_REPLACE,
    Increase = gl.GL_INCR,
    IncreaseWrap = gl.GL_INCR_WRAP,
    Decrease = gl.GL_DECR,
    DecreaseWrap = gl.GL_DECR_WRAP,
    Invert = gl.GL_INVERT
}

enum PixelStoreMode {
    PackingSwapBytes = gl.GL_PACK_SWAP_BYTES,
    PackingLessSignificantBitFirst = gl.GL_PACK_LSB_FIRST,
    PackingRowLength = gl.GL_PACK_ROW_LENGTH,
    PackingImageHeight = gl.GL_PACK_IMAGE_HEIGHT,
    PackingSkipPixels = gl.GL_PACK_SKIP_PIXELS,
    PackingSkipRows = gl.GL_PACK_SKIP_ROWS,
    PackingSkipImages = gl.GL_PACK_SKIP_IMAGES,
    PackingAlignment = gl.GL_PACK_ALIGNMENT,

    UnpackingSwapBytes = gl.GL_UNPACK_SWAP_BYTES,
    UnpackingLessSignificantBitFirst = gl.GL_UNPACK_LSB_FIRST,
    UnpackingRowLength = gl.GL_UNPACK_ROW_LENGTH,
    UnpackingImageHeight = gl.GL_UNPACK_IMAGE_HEIGHT,
    UnpackingSkipPixels = gl.GL_UNPACK_SKIP_PIXELS,
    UnpackingSkipRows = gl.GL_UNPACK_SKIP_ROWS,
    UnpackingSkipImages = gl.GL_UNPACK_SKIP_IMAGES,
    UnpackingAlignment = gl.GL_UNPACK_ALIGNMENT
}

enum ColorBufferSource {
    FrontLeft = gl.GL_FRONT_LEFT,
    FrontRight = gl.GL_FRONT_RIGHT,
    BackLeft = gl.GL_BACK_LEFT,
    BackRight = gl.GL_BACK_RIGHT,
    Front = gl.GL_FRONT,
    Back = gl.GL_BACK,
    Left = gl.GL_LEFT,
    Right = gl.GL_RIGHT,
    ColorAttachment0 = gl.GL_COLOR_ATTACHMENT0,
    ColorAttachment1 = gl.GL_COLOR_ATTACHMENT1,
    ColorAttachment2 = gl.GL_COLOR_ATTACHMENT2,
    ColorAttachment3 = gl.GL_COLOR_ATTACHMENT3,
    ColorAttachment4 = gl.GL_COLOR_ATTACHMENT4,
    ColorAttachment5 = gl.GL_COLOR_ATTACHMENT5,
    ColorAttachment6 = gl.GL_COLOR_ATTACHMENT6,
    ColorAttachment7 = gl.GL_COLOR_ATTACHMENT7,
    ColorAttachment8 = gl.GL_COLOR_ATTACHMENT8,
    ColorAttachment9 = gl.GL_COLOR_ATTACHMENT9,
    ColorAttachment10 = gl.GL_COLOR_ATTACHMENT10,
    ColorAttachment11 = gl.GL_COLOR_ATTACHMENT11,
    ColorAttachment12 = gl.GL_COLOR_ATTACHMENT12,
    ColorAttachment13 = gl.GL_COLOR_ATTACHMENT13,
    ColorAttachment14 = gl.GL_COLOR_ATTACHMENT14,
    ColorAttachment15 = gl.GL_COLOR_ATTACHMENT15
}

enum ReadBlockPixelsFormat {
    StencilIndex = gl.GL_STENCIL_INDEX,
    DepthComponent = gl.GL_DEPTH_COMPONENT,
    DepthStencil = gl.GL_DEPTH_STENCIL,
    Red = gl.GL_RED,
    Green = gl.GL_GREEN,
    Blue = gl.GL_BLUE,
    RGB = gl.GL_RGB,
    BGR = gl.GL_BGR,
    RGBA = gl.GL_RGBA,
    BGRA = gl.GL_BGRA
}

enum ReadBlockPixelsType {
    UnsignedByte = gl.GL_UNSIGNED_BYTE,
    Byte = gl.GL_BYTE,
    UnsignedShort = gl.GL_UNSIGNED_SHORT,
    Short = gl.GL_SHORT,
    UnsignedInt = gl.GL_UNSIGNED_INT,
    Int = gl.GL_INT,
    HalfFloat = gl.GL_HALF_FLOAT,
    Float = gl.GL_FLOAT,
    UnsignedByte332 = gl.GL_UNSIGNED_BYTE_3_3_2,
    UnsignedByte233Rev = gl.GL_UNSIGNED_BYTE_2_3_3_REV,
    UnsignedShort565 = gl.GL_UNSIGNED_SHORT_5_6_5,
    UnsignedShort565Rev = gl.GL_UNSIGNED_SHORT_5_6_5_REV,
    UnsignedShort4444 = gl.GL_UNSIGNED_SHORT_4_4_4_4,
    UnsignedShort4444Rev = gl.GL_UNSIGNED_SHORT_4_4_4_4_REV,
    UnsignedShort5551 = gl.GL_UNSIGNED_SHORT_5_5_5_1,
    UnsignedShort1555Rev = gl.GL_UNSIGNED_SHORT_1_5_5_5_REV,
    UnsignedInt8888 = gl.GL_UNSIGNED_INT_8_8_8_8,
    UnsignedInt8888Rev = gl.GL_UNSIGNED_INT_8_8_8_8_REV,
    UnsignedInt1010102 = gl.GL_UNSIGNED_INT_10_10_10_2,
    UnsignedInt2101010Rev = gl.GL_UNSIGNED_INT_2_10_10_10_REV,
    UnsignedInt248 = gl.GL_UNSIGNED_INT_24_8,
    UnsignedInt10f11f11fRev = gl.GL_UNSIGNED_INT_10F_11F_11F_REV,
    UnsignedInt5999Rev = gl.GL_UNSIGNED_INT_5_9_9_9_REV,
    Float32UnsignedInt248Rev = gl.GL_FLOAT_32_UNSIGNED_INT_24_8_REV
}

enum GetValueNames {
    ColorLogicOp = gl.GL_COLOR_LOGIC_OP,
    ColorArray = gl.GL_COLOR_ARRAY,
    ColorArraySize = gl.GL_COLOR_ARRAY_SIZE,
    ColorArrayStride = gl.GL_COLOR_ARRAY_STRIDE,
    ColorArrayType = gl.GL_COLOR_ARRAY_TYPE,
    EdgeFlagArray = gl.GL_EDGE_FLAG_ARRAY,
    EdgeFlagArrayStride = gl.GL_EDGE_FLAG_ARRAY_STRIDE,
    IndexArray = gl.GL_INDEX_ARRAY,
    IndexArrayStride = gl.GL_INDEX_ARRAY_STRIDE,
    IndexArrayType = gl.GL_INDEX_ARRAY_TYPE,
    IndexLogicOp = gl.GL_INDEX_LOGIC_OP,
    NormalArray = gl.GL_NORMAL_ARRAY,
    NormalArrayStride = gl.GL_NORMAL_ARRAY_STRIDE,
    NormalArrayType = gl.GL_NORMAL_ARRAY_TYPE,
    PolygonOffsetUnits = gl.GL_POLYGON_OFFSET_UNITS,
    PolygonOffsetFactor = gl.GL_POLYGON_OFFSET_FACTOR,
    PolygonOffsetFill = gl.GL_POLYGON_OFFSET_FILL,
    PolygonOffsetLine = gl.GL_POLYGON_OFFSET_LINE,
    PolygonOfffsetPoint = gl.GL_POLYGON_OFFSET_POINT,
    TextureCoordArray = gl.GL_TEXTURE_COORD_ARRAY,
    TextureCoordArraySize = gl.GL_TEXTURE_COORD_ARRAY_SIZE,
    TextureCoordArrayStride = gl.GL_TEXTURE_COORD_ARRAY_STRIDE,
    TextureCoordArrayType = gl.GL_TEXTURE_COORD_ARRAY_TYPE,
    VertexArray = gl.GL_VERTEX_ARRAY,
    VertexArraySize = gl.GL_VERTEX_ARRAY_SIZE,
    VertexArrayStride = gl.GL_VERTEX_ARRAY_STRIDE,
    VertexArrayType = gl.GL_VERTEX_ARRAY_TYPE,
    
    AliasedPointSizeRange = gl.GL_ALIASED_POINT_SIZE_RANGE,
    FeedbackBufferSize = gl.GL_FEEDBACK_BUFFER_SIZE,
    FeedbackBufferType = gl.GL_FEEDBACK_BUFFER_TYPE,
    LightModelAmbient = gl.GL_LIGHT_MODEL_AMBIENT,
    LightModelColorControl = gl.GL_LIGHT_MODEL_COLOR_CONTROL,
    Max3dTextureSize = gl.GL_MAX_3D_TEXTURE_SIZE,
    MaxElementsIndices = gl.GL_MAX_ELEMENTS_INDICES,
    MaxElementsVertices = gl.GL_MAX_ELEMENTS_VERTICES,
    PackImageHeight = gl.GL_PACK_IMAGE_HEIGHT,
    PackSkipImages = gl.GL_PACK_SKIP_IMAGES,
    RescaleNormal = gl.GL_RESCALE_NORMAL,
    SelectionBufferSize = gl.GL_SELECTION_BUFFER_SIZE,
    SmoothLineWidthGranularity = gl.GL_SMOOTH_LINE_WIDTH_GRANULARITY,
    SmoothLineWidthRange = gl.GL_SMOOTH_LINE_WIDTH_RANGE,
    SmoothPointSizeGranularity = gl.GL_SMOOTH_POINT_SIZE_GRANULARITY,
    SmoothPointSizeRange = gl.GL_SMOOTH_POINT_SIZE_RANGE,
    //Texture3D = gl.GL_TEXTURE_3D,
    TextureBinding3D = gl.GL_TEXTURE_BINDING_3D,
    UnpackImageHeight = gl.GL_UNPACK_IMAGE_HEIGHT,
    UnpackSkipImages = gl.GL_UNPACK_SKIP_IMAGES,
    
    CompressedTextureFormats = gl.GL_COMPRESSED_TEXTURE_FORMATS,
    NumCompressedTextureFormats = gl.GL_NUM_COMPRESSED_TEXTURE_FORMATS,
    TextureBindingCubeMap = gl.GL_TEXTURE_BINDING_CUBE_MAP,
    TextureCompresssionHint = gl.GL_TEXTURE_COMPRESSION_HINT,
    
    BlendDestinationAlpha = gl.GL_BLEND_DST_ALPHA,
    BlendDestinationRGB = gl.GL_BLEND_DST_RGB,
    BlendSourceAlpha = gl.GL_BLEND_SRC_ALPHA,
    BlendSourceRGB = gl.GL_BLEND_SRC_RGB,
    CurrentFogCoord = gl.GL_CURRENT_FOG_COORD,
    CurrentSecondaryColor = gl.GL_CURRENT_SECONDARY_COLOR,
    FogCoordArrayStride = gl.GL_FOG_COORD_ARRAY_STRIDE,
    FogCoordArrayType = gl.GL_FOG_COORD_ARRAY_TYPE,
    FogCoordSource = gl.GL_FOG_COORD_SRC,
    MaxTextureLodBias = gl.GL_MAX_TEXTURE_LOD_BIAS,
    PointSizeMin = gl.GL_POINT_SIZE_MIN,
    PointSizeMax = gl.GL_POINT_SIZE_MAX,
    PointFadeThresholdSize = gl.GL_POINT_FADE_THRESHOLD_SIZE,
    PointDistanceAttenuation = gl.GL_POINT_DISTANCE_ATTENUATION,
    SecondaryColorArraySize = gl.GL_SECONDARY_COLOR_ARRAY_SIZE,
    SecondaryColorArrayStride = gl.GL_SECONDARY_COLOR_ARRAY_STRIDE,
    SecondaryColorArrayType = gl.GL_SECONDARY_COLOR_ARRAY_TYPE,
    
    ArrayBufferBinding = gl.GL_ARRAY_BUFFER_BINDING,
    ColorArrayBufferBinding = gl.GL_COLOR_ARRAY_BUFFER_BINDING,
    EdgeFlagArrayBufferBinding = gl.GL_EDGE_FLAG_ARRAY_BUFFER_BINDING,
    ElementArrayBufferBinding = gl.GL_ELEMENT_ARRAY_BUFFER_BINDING,
    FogCoordArrayBufferBinding = gl.GL_FOG_COORD_ARRAY_BUFFER_BINDING,
    IndexArrayBufferBinding = gl.GL_INDEX_ARRAY_BUFFER_BINDING,
    NormalArrayBufferBinding = gl.GL_NORMAL_ARRAY_BUFFER_BINDING,
    SecondaryColorArrayBufferBinding = gl.GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING,
    TextureCoordArrayBufferBinding = gl.GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING,
    VertexArrayBufferBinding = gl.GL_VERTEX_ARRAY_BUFFER_BINDING,
    
    BlendEquationAlpha = gl.GL_BLEND_EQUATION_ALPHA,
    BlendEquationRGB = gl.GL_BLEND_EQUATION_RGB,
    DrawBuffer0 = gl.GL_DRAW_BUFFER0,
    DrawBuffer1 = gl.GL_DRAW_BUFFER1,
    DrawBuffer2 = gl.GL_DRAW_BUFFER2,
    DrawBuffer3 = gl.GL_DRAW_BUFFER3,
    DrawBuffer4 = gl.GL_DRAW_BUFFER4,
    DrawBuffer5 = gl.GL_DRAW_BUFFER5,
    DrawBuffer6 = gl.GL_DRAW_BUFFER6,
    DrawBuffer7 = gl.GL_DRAW_BUFFER7,
    DrawBuffer8 = gl.GL_DRAW_BUFFER8,
    DrawBuffer9 = gl.GL_DRAW_BUFFER9,
    DrawBuffer10 = gl.GL_DRAW_BUFFER10,
    DrawBuffer11 = gl.GL_DRAW_BUFFER11,
    DrawBuffer12 = gl.GL_DRAW_BUFFER12,
    DrawBuffer13 = gl.GL_DRAW_BUFFER13,
    DrawBuffer14 = gl.GL_DRAW_BUFFER14,
    DrawBuffer15 = gl.GL_DRAW_BUFFER15,
    FragmentShaderDerivativeHint = gl.GL_FRAGMENT_SHADER_DERIVATIVE_HINT,
    CombinedTextureImageUnits = gl.GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
    MaxDrawBuffers = gl.GL_MAX_DRAW_BUFFERS,
    MaxFragmentUniformComponents = gl.GL_MAX_FRAGMENT_UNIFORM_COMPONENTS,
    MaxTextureCoords = gl.GL_MAX_TEXTURE_COORDS,
    MaxTextureImageUnits = gl.GL_MAX_TEXTURE_IMAGE_UNITS,
    MaxVaryingFloats = gl.GL_MAX_VARYING_FLOATS,
    MaxVertexAttribs = gl.GL_MAX_VERTEX_ATTRIBS,
    maxVertexTextureImageUnits = gl.GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS,
    MaxVertexUniformComponents = gl.GL_MAX_VERTEX_UNIFORM_COMPONENTS,
    PointSprite = gl.GL_POINT_SPRITE,
    StencilBackFail = gl.GL_STENCIL_BACK_FAIL,
    StencilBackFunc = gl.GL_STENCIL_BACK_FUNC,
    StencilBackPassDepthFail = gl.GL_STENCIL_BACK_PASS_DEPTH_FAIL,
    StencilBackPassDepthPass = gl.GL_STENCIL_BACK_PASS_DEPTH_PASS,
    StencilBackRef = gl.GL_STENCIL_BACK_REF,
    StencilBackValueMask = gl.GL_STENCIL_BACK_VALUE_MASK,
    StencilBackWriteMask = gl.GL_STENCIL_BACK_WRITEMASK,
    VertexProgramPointSize = gl.GL_VERTEX_PROGRAM_POINT_SIZE,
    VertexProgramTwoSide = gl.GL_VERTEX_PROGRAM_TWO_SIDE,
    
    CurrentRasterSecondaryColor = gl.GL_CURRENT_RASTER_SECONDARY_COLOR,
    PixelPackBufferBinding = gl.GL_PIXEL_PACK_BUFFER_BINDING,
    PixelUnpackBufferBinding = gl.GL_PIXEL_UNPACK_BUFFER_BINDING,
    
    LineWidthGranularity = gl.GL_LINE_WIDTH_GRANULARITY,
    LineWidthRange = gl.GL_LINE_WIDTH_RANGE,
    PointSizeGranularity = gl.GL_POINT_SIZE_GRANULARITY,
    PointSizeRange = gl.GL_POINT_SIZE_RANGE,
    BlendEquation = gldepcnst.GL_BLEND_EQUATION,
    
    ColorMatrix = gl.GL_COLOR_MATRIX,
    ColorMatrixStackDepth = gl.GL_COLOR_MATRIX_STACK_DEPTH,
    ColorTable = gl.GL_COLOR_TABLE,
    Convolution1D = gl.GL_CONVOLUTION_1D,
    Convolution2D = gl.GL_CONVOLUTION_2D,
    Histogram = gl.GL_HISTOGRAM,
    MaxColorMatrixStackDepth = gl.GL_MAX_COLOR_MATRIX_STACK_DEPTH,
    MinMax = gl.GL_MINMAX,
    PostColorMatrixColorTable = gl.GL_POST_COLOR_MATRIX_COLOR_TABLE,
    PostColorMatrixRedBias = gl.GL_POST_COLOR_MATRIX_RED_BIAS,
    PostColorMatrixGreenBias = gl.GL_POST_COLOR_MATRIX_GREEN_BIAS,
    PostColorMatrixBlueBias = gl.GL_POST_COLOR_MATRIX_BLUE_BIAS,
    PostColorMatrixAlphaBias = gl.GL_POST_COLOR_MATRIX_ALPHA_BIAS,
    PostColorMatrixRedScale = gl.GL_POST_COLOR_MATRIX_RED_SCALE,
    PostColorMatrixGreenScale = gl.GL_POST_COLOR_MATRIX_GREEN_SCALE,
    PostColorMatrixBlueScale = gl.GL_POST_COLOR_MATRIX_BLUE_SCALE,
    PostColorMatrixAlphaScale = gl.GL_POST_COLOR_MATRIX_ALPHA_SCALE,
    PostConvolutionColorTable = gl.GL_POST_CONVOLUTION_COLOR_TABLE,
    PostConvolutionRedBias = gl.GL_POST_CONVOLUTION_RED_BIAS,
    PostConvolutionGreenBias = gl.GL_POST_CONVOLUTION_GREEN_BIAS,
    PostConvolutionBlueBias = gl.GL_POST_CONVOLUTION_BLUE_BIAS,
    PostConvolutionAlphaBias = gl.GL_POST_CONVOLUTION_ALPHA_BIAS,
    PostConvolutionRedScale = gl.GL_POST_CONVOLUTION_RED_SCALE,
    PostConvolutionGreenScale = gl.GL_POST_CONVOLUTION_GREEN_SCALE,
    PostConvolutionBlueScale = gl.GL_POST_CONVOLUTION_BLUE_SCALE,
    PostConvolutionALphaScale = gl.GL_POST_CONVOLUTION_ALPHA_SCALE,
    Seperable2D = gl.GL_SEPARABLE_2D,
    
    CurrentRasterTextureCoords = gl.GL_CURRENT_RASTER_TEXTURE_COORDS,
    Texture1D = gl.GL_TEXTURE_1D,
    TextureBinding1D = gl.GL_TEXTURE_BINDING_1D,
    Texture2D = gl.GL_TEXTURE_2D,
    TextureBinding2D = gl.GL_TEXTURE_BINDING_2D,
    Texture3D = gl.GL_TEXTURE_3D,
    TexutreBinding3D = gl.GL_TEXTURE_BINDING_3D,
    TextureGenS = gl.GL_TEXTURE_GEN_S,
    TextureGenT = gl.GL_TEXTURE_GEN_T,
    TextureGenR = gl.GL_TEXTURE_GEN_R,
    TextureGenQ = gl.GL_TEXTURE_GEN_Q,
    TextureMatrix = gl.GL_TEXTURE_MATRIX,
    TextureStackDepth = gl.GL_TEXTURE_STACK_DEPTH
}

enum ErrorTypes {
    NoError = gl.GL_NO_ERROR,
    InvalidEnum = gl.GL_INVALID_ENUM,
    InvalidValue = gl.GL_INVALID_VALUE,
    InvalidOperation = gl.GL_INVALID_OPERATION,
    StackOverflow = gl.GL_STACK_OVERFLOW,
    StackUnderflow = gl.GL_STACK_UNDERFLOW,
    OutOfMemory = gl.GL_OUT_OF_MEMORY,
    TableTooLarge = gl.GL_TABLE_TOO_LARGE
}

enum GetStringNames {
    Vendor = gl.GL_VENDOR,
    Renderer = gl.GL_RENDERER,
    Version = gl.GL_VERSION,
    ShadingLanguageVersion = gl.GL_SHADING_LANGUAGE_VERSION,
    Extension = gl.GL_EXTENSIONS
}

enum GetTargetTexture {
    Texture1D = gl.GL_TEXTURE_1D,
    Texture2D = gl.GL_TEXTURE_2D,
    Texture3D = gl.GL_TEXTURE_3D,
    TextureCubeMap = gl.GL_TEXTURE_CUBE_MAP
}

enum GetTargetTextureParameter {
    TextureMagFilter = gl.GL_TEXTURE_MAG_FILTER,
    TextureMinFilter = gl.GL_TEXTURE_MIN_FILTER,
    TextureMinLod = gl.GL_TEXTURE_MIN_LOD,
    TextureMaxLod = gl.GL_TEXTURE_MAX_LOD,
    TextureBaseLevel = gl.GL_TEXTURE_BASE_LEVEL,
    TextureMaxLevel = gl.GL_TEXTURE_MAX_LEVEL,
    TextureWrapS = gl.GL_TEXTURE_WRAP_S,
    TextureWrapT = gl.GL_TEXTURE_WRAP_T,
    TextureWrapR = gl.GL_TEXTURE_WRAP_R,
    TextureBorderColor = gl.GL_TEXTURE_BORDER_COLOR,
    TexturePriority = gl.GL_TEXTURE_PRIORITY,
    TextureResident = gl.GL_TEXTURE_RESIDENT,
    TextureCompareMode = gl.GL_TEXTURE_COMPARE_MODE,
    TextureCompareFunc = gl.GL_TEXTURE_COMPARE_FUNC,
    DepthTextureMode = gl.GL_DEPTH_TEXTURE_MODE,
    GenerateMipMap = gl.GL_GENERATE_MIPMAP
}

enum GetTextureParameter {
    Width = gl.GL_TEXTURE_WIDTH,
    Height = gl.GL_TEXTURE_HEIGHT,
    Depth = gl.GL_TEXTURE_DEPTH,
    InternalFormat = gl.GL_TEXTURE_INTERNAL_FORMAT,
    Border = gl.GL_TEXTURE_BORDER,
    RedSize = gl.GL_TEXTURE_RED_SIZE,
    GreenSize = gl.GL_TEXTURE_GREEN_SIZE,
    BlueSize = gl.GL_TEXTURE_BLUE_SIZE,
    AlphaSize = gl.GL_TEXTURE_ALPHA_SIZE,
    LuminanceSize = gl.GL_TEXTURE_LUMINANCE_SIZE,
    IntensitySize = gl.GL_TEXTURE_INTENSITY_SIZE,
    DepthSize = gl.GL_TEXTURE_DEPTH_SIZE,
    Compressed = gl.GL_TEXTURE_COMPRESSED,
    CompressedImageSize = gl.GL_TEXTURE_COMPRESSED_IMAGE_SIZE
}

enum Capabilities {
    AlphaTest = gl.GL_ALPHA_TEST,
    AutoNormal = gl.GL_AUTO_NORMAL,
    Blend = gl.GL_BLEND,
    /*ClipPlane0 = gl.GL_CLIP_PLANE0,
    ClipPlane1 = gl.GL_CLIP_PLANE1,
    ClipPlane2 = gl.GL_CLIP_PLANE2,
    ClipPlane3 = gl.GL_CLIP_PLANE3,
    ClipPlane4 = gl.GL_CLIP_PLANE4,
    ClipPlane5 = gl.GL_CLIP_PLANE5,
    ClipPlane6 = gl.GL_CLIP_PLANE6,
    ClipPlane7 = gl.GL_CLIP_PLANE7,
    ClipPlane8 = gl.GL_CLIP_PLANE8,
    ClipPlane9 = gl.GL_CLIP_PLANE9,
    ClipPlane10 = gl.GL_CLIP_PLANE10,
    ClipPlane11 = gl.GL_CLIP_PLANE11,
    ClipPlane12 = gl.GL_CLIP_PLANE12,
    ClipPlane13 = gl.GL_CLIP_PLANE13,
    ClipPlane14 = gl.GL_CLIP_PLANE14,
    ClipPlane15 = gl.GL_CLIP_PLANE15,*/
    ColorArray = gl.GL_COLOR_ARRAY,
    ColorLogicOp = gl.GL_COLOR_LOGIC_OP,
    ColorMaterial = gl.GL_COLOR_MATERIAL,
    ColorSum = gl.GL_COLOR_SUM,
    ColorTable = gl.GL_COLOR_TABLE,
    Convolution1D = gl.GL_CONVOLUTION_1D,
    Convolution2D = gl.GL_CONVOLUTION_2D,
    CullFace = gl.GL_CULL_FACE,
    DepthTest = gl.GL_DEPTH_TEST,
    Dither = gl.GL_DITHER,
    EdgeFlagArray = gl.GL_EDGE_FLAG_ARRAY,
    Fog = gl.GL_FOG,
    FogCoordArray = gl.GL_FOG_COORD_ARRAY,
    Histogram = gl.GL_HISTOGRAM,
    IdnexArray = gl.GL_INDEX_ARRAY,
    IndexLogicOp = gl.GL_INDEX_LOGIC_OP,
    Light0 = gl.GL_LIGHT0,
    Light1 = gl.GL_LIGHT1,
    Light2 = gl.GL_LIGHT2,
    Light3 = gl.GL_LIGHT3,
    Light4 = gl.GL_LIGHT4,
    Light5 = gl.GL_LIGHT5,
    Light6 = gl.GL_LIGHT6,
    Light7 = gl.GL_LIGHT7,
    Lighting = gl.GL_LIGHTING,
    LineSmooth = gl.GL_LINE_SMOOTH,
    LineStipple = gl.GL_LINE_STIPPLE,
    Map1Color4 = gl.GL_MAP1_COLOR_4,
    Map1Index = gl.GL_MAP1_INDEX,
    Map1Normal = gl.GL_MAP1_NORMAL,
    Map1TextureCoord1 = gl.GL_MAP1_TEXTURE_COORD_1,
    Map1TextureCoord2 = gl.GL_MAP1_TEXTURE_COORD_2,
    Map1TextureCoord3 = gl.GL_MAP1_TEXTURE_COORD_3,
    Map1TextureCoord4 = gl.GL_MAP1_TEXTURE_COORD_4,
    Map2Color4 = gl.GL_MAP2_COLOR_4,
    Map2Index = gl.GL_MAP2_INDEX,
    Map2Normal = gl.GL_MAP2_NORMAL,
    Map2TextureCoord1 = gl.GL_MAP2_TEXTURE_COORD_1,
    Map2TextureCoord2 = gl.GL_MAP2_TEXTURE_COORD_2,
    Map2TextureCoord3 = gl.GL_MAP2_TEXTURE_COORD_3,
    Map2TextureCoord4 = gl.GL_MAP2_TEXTURE_COORD_4,
    Map2Vertex3 = gl.GL_MAP2_VERTEX_3,
    Map2Vertex4 = gl.GL_MAP2_VERTEX_4,
    MinMax = gl.GL_MINMAX,
    MultiSample = gl.GL_MULTISAMPLE,
    NormalArray = gl.GL_NORMAL_ARRAY,
    Normalize = gl.GL_NORMALIZE,
    PointSmooth = gl.GL_POINT_SMOOTH,
    PointSprite = gl.GL_POINT_SPRITE,
    PolygonSmooth = gl.GL_POLYGON_SMOOTH,
    PolygonOffsetFill = gl.GL_POLYGON_OFFSET_FILL,
    PolygonOffsetLine = gl.GL_POLYGON_OFFSET_LINE,
    PolygonOffsetPoint = gl.GL_POLYGON_OFFSET_POINT,
    PolygonStipple = gl.GL_POLYGON_STIPPLE,
    PostColorMatrixColorTable = gl.GL_POST_COLOR_MATRIX_COLOR_TABLE,
    PostConvolutionColorTable = gl.GL_POST_CONVOLUTION_COLOR_TABLE,
    RescaleNormal = gl.GL_RESCALE_NORMAL,
    SampleAlphaToCoverage = gl.GL_SAMPLE_ALPHA_TO_COVERAGE,
    SampleCoverage = gl.GL_SAMPLE_COVERAGE,
    ScissorTest = gl.GL_SCISSOR_TEST,
    SecondaryColorArray = gl.GL_SECONDARY_COLOR_ARRAY,
    Seperable2D = gl.GL_SEPARABLE_2D,
    StencilTest = gl.GL_STENCIL_TEST,
    Texture1D = gl.GL_TEXTURE_1D,
    Texture2D = gl.GL_TEXTURE_2D,
    Texture3D = gl.GL_TEXTURE_3D,
    TextureCoordArray = gl.GL_TEXTURE_COORD_ARRAY,
    TextureCubeMap = gl.GL_TEXTURE_CUBE_MAP,
    TextureGenQ = gl.GL_TEXTURE_GEN_Q,
    TextureGenR = gl.GL_TEXTURE_GEN_R,
    TextureGenS = gl.GL_TEXTURE_GEN_S,
    TextureGenT = gl.GL_TEXTURE_GEN_T,
    VertexArray = gl.GL_VERTEX_ARRAY,
    VertexProgramPointSize = gl.GL_VERTEX_PROGRAM_POINT_SIZE,
    VertexProgramTwoSide = gl.GL_VERTEX_PROGRAM_TWO_SIDE,
    Error = 0
}

enum TextureWrapping {
    ClampEdge = gl.GL_CLAMP_TO_EDGE,
    ClampBorder = gl.GL_CLAMP_TO_BORDER,
    Repeat = gl.GL_REPEAT,
    MirroredRepeat = gl.GL_MIRRORED_REPEAT
}

enum TextureFilter {
    Nearest = gl.GL_NEAREST,
    Linear = gl.GL_LINEAR,
    NearestMipmapNearest = gl.GL_NEAREST_MIPMAP_NEAREST,
    LinearMipmapNearest = gl.GL_LINEAR_MIPMAP_NEAREST,
    NearestMipmapLinear = gl.GL_NEAREST_MIPMAP_LINEAR,
    LinearMipmapLinear = gl.GL_LINEAR_MIPMAP_LINEAR
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

void glLogicOp(LogicOperators op = LogicOperators.Copy) {
    gl.glLogicOp(op);
}

void glStencilFunc(LogicalComparison func, int ref_, uint mask) {
    gl.glStencilFunc(func, ref_, mask);
}

void glStencilOp(StencilOperators sfail = StencilOperators.Keep, StencilOperators dpfail = StencilOperators.Keep, StencilOperators dppass = StencilOperators.Keep) {
    gl.glStencilOp(sfail, dpfail, dppass);
}

void glDepthFunc(LogicalComparison func) {
    gl.glDepthFunc(func);
}

void glPixelStore(PixelStoreMode pname, float param) {
    gl.glPixelStoref(pname, param);
}

void glPixelStore(PixelStoreMode pname, int param) {
    gl.glPixelStorei(pname, param);
}

void glReadBuffer(ColorBufferSource mode) {
    gl.glReadBuffer(mode);
}

void[] glReadPixels(int x, int y, int width, int height, ReadBlockPixelsFormat format, ReadBlockPixelsType type) {
    void[] ret;
    gl.glReadPixels(x, y, width, height, format, type, ret.ptr);
    return ret;
}

bool glGetBoolean(GetValueNames pname) {
    bool ret;
    gl.glGetBooleanv(pname, cast(ubyte*)&ret);
    return ret;
}

double glGetDouble(GetValueNames pname) {
    double ret;
    gl.glGetDoublev(pname, &ret);
    return ret;
}

float glGetBoolean(GetValueNames pname) {
    float ret;
    gl.glGetFloatv(pname, &ret);
    return ret;
}

int glGetInteger(GetValueNames pname) {
    int ret;
    gl.glGetIntegerv(pname, &ret);
    return ret;
}

ErrorTypes glGetError() {
    return cast(ErrorTypes)gl.glGetError();
}

string glGetString(GetStringNames name) {
    import core.stdc.string : strlen;
    char* cstr;
    cstr = cast(char*)gl.glGetString(name);
    return cast(string)(cstr ? cstr[0 .. strlen(cstr)] : cstr[0 .. 0]);
}

/*TODO: requires to allocate for return variable (img)
bindFunc(cast(void**)&glGetTexImage, "glGetTexImage");*/

float[] glGetTexParameterFloat(GetTargetTexture target, GetTargetTextureParameter pname) {
    float[] ret;
    gl.glGetTexParameterfv(target, pname, ret.ptr);
    return ret;
}

int[] glGetTexParameterInteger(GetTargetTexture target, GetTargetTextureParameter pname) {
    int[] ret;
    gl.glGetTexParameteriv(target, pname, ret.ptr);
    return ret;
}

float[] glGetTexLevelParameterFloat(GetTargetTexture target, int level, GetTextureParameter pname) {
    float[] ret;
    gl.glGetTexLevelParameterfv(target, level, pname, ret.ptr);
    return ret;
}

int[] glGetTexLevelParameterInteger(GetTargetTexture target, int level, GetTextureParameter pname) {
    int[] ret;
    gl.glGetTexLevelParameteriv(target, level, pname, ret.ptr);
    return ret;
}

bool glIsEnabled(Capabilities cap) {
    return cast(bool)gl.glIsEnabled(cap);
}

void glDepthRange(float nearVal = 0, float farVal = 1)
in {
    assert(nearVal >= -1 && nearVal <= 1);
    assert(farVal >= -1 && farVal <= 1);
} body {
    gl.glDepthRange(nearVal, farVal);
}