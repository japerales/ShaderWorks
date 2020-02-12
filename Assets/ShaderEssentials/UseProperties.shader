Shader "Holistic/AllProps" 
{
    Properties {
        _myColor ("Example Color", Color) = (1,1,1,1)
        _myRange ("Example Range", Range(0,5)) = 1
        _myTex ("Example Texture", 2D) = "white" {}
        _myCube ("Example Cube", CUBE) = "" {}
        _myFloat ("Example Float", Float) = 0.5
        _myVector ("Example Vector", Vector) = (0.5,1,1,1)
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _myColor;
        half _myRange;
        sampler2D _myTex;
        samplerCUBE _myCube;
        float _myFloat;
        float4 _myVector;

        struct Input {
            float2 uv_myTex; //lo que hay detrás de uv debe coincidir con el nombre de la textura.
            float3 worldRefl;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange).rgb; /*tex2D coge la textura 2D como lienzo, y IN.uv_myTex indica la coordenada UV que corresponde al pixel actual.
			//Cada vertex tiene asociado una coordenada UV en el plano 2D. La mesh también tiene información de qué vertices forman cada triángulo. 
			De esta forma se triangula la coordenada UV exacta para el pixel actual; se busca dicha coordenada en la textura de muestra (sampler) y se extra el color, que se proyecta sobre el mesh.
			*/
            o.Emission = texCUBE (_myCube, IN.worldRefl).rgb;
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
