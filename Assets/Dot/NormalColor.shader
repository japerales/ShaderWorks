Shader "Holistic/NormalColor"
{
	Properties{

		_Slider("NormalCutAmount", Range(0,1)) = 1
		_Normal("Normal Map", 2D) = "bump" {}
	}
		SubShader
	{

		CGPROGRAM
		#pragma surface surf Lambert

		half _Slider;
		sampler2D _Normal;

		struct Input
        {
            float3 viewDir;
			float2 uv_Normal;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
			//SI NO TENEMOS NORMAL MAP / NO HACEMOS UNPACK NORMAL
			//o.Normal son las normales calculadas en cada fotograma con respecto al espacio del world, y no del object.
			//las normales del azul están invertidas por lo que "para afuera" en z se considera -1, porque el valor positivo se considera
			//la vista del jugador. Por tanto, si ves de frente al conejo, esa z normal es negativa.
			/*SI ASIGNAMOS UN NORMAL MAP A o.Normal la cosa cambia... Y las normales se vuelven de tangent space por lo que salen azules*/
			o.Normal = UnpackNormal(tex2D(_Normal, IN.uv_Normal));
			//o.Albedo = o.Normal;
			
				if (o.Normal.b > _Slider)
				o.Albedo = float3(0, 0, 1);
				

        }
        ENDCG
    }
    FallBack "Diffuse"
}
