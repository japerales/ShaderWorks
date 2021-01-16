Shader "Holistic/BasicPhong"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (1,1,1,1) //no hace falta definirlo abajo porque ya existe en las librerias
		_Spec ("Specular", Range(0,1)) = 0.5
		_Gloss("Gloss", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
        LOD 200

        CGPROGRAM
        #pragma surface surf BlinnPhong

        #pragma target 3.0

        struct Input
        {
            float2 uv_MainTex;
			float3 viewDir;
        };

        fixed4 _Color;
		half _Spec;
		fixed _Gloss;

        //SurfaceOutput: mirar en la doc de unity sobre qué contiene
        void surf (Input IN, inout SurfaceOutput o)
        {
			//o.Albedo = dot(normalize(IN.viewDir+o.) _Color.rgb;
			o.Albedo = _Color.rgb;
			o.Specular = _Spec;
			o.Gloss = _Gloss;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
