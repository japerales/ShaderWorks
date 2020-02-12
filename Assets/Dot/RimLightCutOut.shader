Shader "Holistic/RimColorCutOut"
{
	Properties{


		_RimColor("Rim Color", Color) = (0,0.5,0.5,0)
		_CutOut("Cut Out", Range(0,1)) = 1
	}
		SubShader
	{

		CGPROGRAM
		#pragma surface surf Lambert

		float4 _RimColor;
	half _CutOut;
		struct Input
        {
            float3 viewDir; //Si algo depende de la camara del usuario, llamamos a viewDir
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
			/*saturate en este caso no tiene ningun efecto, pero es más limpio, puesto que el dot recordemos que puede dar entre
			1 y -1. Menos de 0 no nos interesa y no tiene efecto sobre el color. Saturate clampea entre 0 y 1*/
			half rim = saturate(1-dot(normalize(IN.viewDir), o.Normal));
			if (rim > _CutOut)
				o.Emission = _RimColor.rgb * rim;

        }
        ENDCG
    }
    FallBack "Diffuse"
}
