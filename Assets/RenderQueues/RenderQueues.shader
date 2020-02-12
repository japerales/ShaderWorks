Shader "Custom/RenderQueues"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

    }
    SubShader
    {
		//Buffers:
		/*
		El frame Buffer es un array en memoria que guarda el color de cada pixel en la pantalla.
		El ZBuffer (o Depth Buffer) es otro array análogo que tiene como cometido encargarse de qué objetos aparecen por delante de otros, en función de su profundidad con respecto a la cámara.
		Analiza previamente si hay algún valor en el frame buffer. Si no, le da un valor de profundidad en ese momento. Cuanto más lejos está el objeto, más alto es el número que se da.
		Si el framebuffer quiere pintar en un pixel ya pintado previamente, antes que nada hace que el zbuffer mire si existe algún valor ahí. Si el valor es mayor que el que hay, no se escribe nada.
		Si el valor es menor, entonces se actualiza el zbuffer con ese nuevo valor, por ejemplo: el valor anterior era 3, y ahora es 1. Además, esto permite al frame buffer sobreescribir el nuevo valor de color, 
		ya que está delante del anterior.
		Por ello, para obtener la máxima eficiencia algoritmica, se pintan primero los objetos que están más cerca de la cámara. Es decir, se pinta de adelante a atrás, evitando reescribir en el frame buffer.
		
		Generalmente esto suele ser así, aunque existen excepciones, como las transparencias.
		Por otro lado, tenemos las render queues, que son números que funcionan como capas. Cuanto más bajo es ese número, más atrás se pintan los objetos. Por defecto hay 5 render queues, asociados a unos tags.

		*/
		ZWrite Off
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
