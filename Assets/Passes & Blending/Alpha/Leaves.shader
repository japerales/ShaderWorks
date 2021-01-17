Shader "Holistic/Leaves" {
Properties{
		_MainTex ("MainTex", 2D) = "white" {}

	}
	SubShader{
		Tags{
			"Queue" = "Transparent" //si no ponemos la queue así
			//el gráfico no recibirá el alpha test y no habrá
			//reordenación.
		}


		CGPROGRAM //añadimos alpha:fade para activar el alpha
		#pragma surface surf Lambert alpha:fade

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"

}
