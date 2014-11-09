module devisualization.util.opengl.function_wrappers.v_1_4;
import gl = derelict.opengl3.gl;
public import devisualization.util.opengl.function_wrappers.v_1_0 : BlendFactors;
public import devisualization.util.opengl.function_wrappers.v_1_1 : Primitives;

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