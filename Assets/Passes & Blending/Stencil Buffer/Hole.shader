Shader "Holistic/Hole" {
	Properties {
		_MainTex ("Diffuse", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue"="Geometry-1" } //dibujado antes que la geometría.

		
		ZWrite Off //si zwrite está en On se tendrá en cuenta
		//la prioridad del quad y se pondrá por delante
		ColorMask 0 //si el colorMask se pone a RGB, se pinta la textura
		//de blanco, y todo aquello que no enmascara
		Stencil
		{
			Ref 1 //a los pixeles de este shader le damos el valor 1
			Comp always //the stencil test siempre ocurre
			Pass replace //operación: reemplazamos los pixeles.
		}
		
		CGPROGRAM
		#pragma surface surf Lambert


		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
