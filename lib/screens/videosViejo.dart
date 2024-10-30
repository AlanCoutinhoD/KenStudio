import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TikTokVideoScreen extends StatefulWidget {
  @override
  _TikTokVideoScreenState createState() => _TikTokVideoScreenState();
}

class _TikTokVideoScreenState extends State<TikTokVideoScreen> {
  // Lista de URLs de videos de prueba
  final List<Map<String, String>> videoData = [
    {
      'username': 'Noe Alejandro',
      'userhandle': '@Noeon',
      'profileImage': 'https://yt3.googleusercontent.com/LSzYgCI1omHqqJ_kwGclTsZ68_jstIUpJNMjL64D0pD8vJrNEmXz5QFfC05zn5PHe4UGhKpyKw=s900-c-k-c0x00ffffff-no-rj',
      'videoUrl': 'https://kenstudioucket.s3.us-east-1.amazonaws.com/Minion%20tarolero.mp4?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEPP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIQDLt1gluRCoyiPOg1%2F01q7SA90Nkrq15hc4kpQ4BLZDKQIgadg2wJWeVQHyf%2FZLqCV3Q2G3tTrYkV%2Fe0h%2FCOqiCEToq4wMIbBABGgw5MTQxMDQ3NjE0NTYiDN801XtX2hyJPQ0rgyrAA7xbxzI5zUYhACK%2BBQvBfSWpohNQUOyFu1sF%2FOqUchhQP%2Flfh6FBIzV%2BaUJHSutDcE%2FmvWcntV3Nm4eNZCZTWhMrHr1xkiG%2BZWRENIfneKUkQUIgtXUZ4ScKeLLHvpod7EX96iCS%2B%2BsTNx43dImFWPwJ4lmJStMAyepq1i3L1Jm5H%2Bt1TICgUFwr7WEiVSDEYuHwVaO%2Bgh77JL0BGRFv7Ke3BT8C3CA3MAeeWThtnnQT3SQLZSYmKgEt3Dwo%2Fczjtz9X7SfWd09oZLO2ddjrj7%2BtLAKJysIDYwefRvVP2Yvl7myOMXbI3ZAa8NSzg6BvOEUNmiJx9DZzGrlvpwxzlHDkf2H1pWoZYC1cxB3KY3Wsshh6ZQytQQOh7Ypal47ddAeeNMYnlNAsotrPLhI2oeG7Gd7lKn%2FD3UI5C9QeEnTkydfeu3SuIM48qmxBZuEMdgcrFWK4kt2kwgMYydl4if0fTeGMLLENIrqtXSfuwnMeLNSNr5bLBnviNheE1%2FiWd8ABrvBtMjaNJNHrW4fOs%2F8sBhzAZH4LG8OYZedCN9waFfdO898TWUNVq06peuYLWSC1ouZU%2F8bOuQGgOZhfMR8wn6aGuQY6twI%2B1pYhDdSOoLPAt3McHgo4IqldoPD7goZGMatzzjfoz06IxVvDlvuf6Oq5Zh4Vccetd22hSvCzKYH9vugzC7RqU5ZqvKatZRWnugr3X%2B2z%2BEQFNpvuKN%2BVTGxoTeyYUCHj6zprfu2iaJ06WXYZJp2GZXl%2BVTwIe7i%2FMxdTEe6E8f8muvCQEnH13QEMQKogV86US73AxzcYpqP8zY5zrrXv1ebJS1xbSlO8D4RYFkhw9RW%2BcQJv8aWMqmc0HH0W7qI2bwi9C2UWk%2FIyj%2FXcjCWoYa43WgINACKSWkZJ3qayRARnxk4p93gTXEC0DsZFMqcZTlbxHEn5bX6gP5SilMCfB43y9oBVB2LPji%2BG5aN7ftndAgyv24kUT%2F0I2pc0urSDHFeYvkEN75%2B%2FCqUa9Zxg1TB1gK7FXQ%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA5JVHDXRYMA5AODUL%2F20241030%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241030T024049Z&X-Amz-Expires=43200&X-Amz-SignedHeaders=host&X-Amz-Signature=0f3794f5bc9568e212d1071f6c47b097ca2c6b73008e7c2df30973d2fb123bce',
      'title': 'Evento de 15 años',
      'description': 'Me disfrace de minion y anduve bien arrecho'
    },
    {
      'username': 'María García',
      'userhandle': '@mariagarcia',
      'profileImage': 'https://scontent.ftgz2-1.fna.fbcdn.net/v/t39.30808-6/361609173_290338383516902_148942040969675955_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeGiqzfyU-sYlnidhtQxNeiYB0AuegqO28sHQC56Co7byxadzn9MZs06SzWLAtXT6lLUj0OpHfrh_g61sDnZeKEr&_nc_ohc=vNo9xE1VF1oQ7kNvgFbfZpy&_nc_zt=23&_nc_ht=scontent.ftgz2-1.fna&_nc_gid=AcLMmhJdh9MaoOrjwEU1WuH&oh=00_AYAwnf2Ca433O6PJL-F4VtXkzUEaRzi6ngH6DVSTJVeEjA&oe=671E106F',
      'videoUrl': 'https://kenstudioucket.s3.us-east-1.amazonaws.com/happi%20happi%20happi%20%23shorts%20%23happyhappyhappy%20%23catmemes%20%23cat%20%23meme%20%23trending%20%23spyde.mp4?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEPP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIQDLt1gluRCoyiPOg1%2F01q7SA90Nkrq15hc4kpQ4BLZDKQIgadg2wJWeVQHyf%2FZLqCV3Q2G3tTrYkV%2Fe0h%2FCOqiCEToq4wMIbBABGgw5MTQxMDQ3NjE0NTYiDN801XtX2hyJPQ0rgyrAA7xbxzI5zUYhACK%2BBQvBfSWpohNQUOyFu1sF%2FOqUchhQP%2Flfh6FBIzV%2BaUJHSutDcE%2FmvWcntV3Nm4eNZCZTWhMrHr1xkiG%2BZWRENIfneKUkQUIgtXUZ4ScKeLLHvpod7EX96iCS%2B%2BsTNx43dImFWPwJ4lmJStMAyepq1i3L1Jm5H%2Bt1TICgUFwr7WEiVSDEYuHwVaO%2Bgh77JL0BGRFv7Ke3BT8C3CA3MAeeWThtnnQT3SQLZSYmKgEt3Dwo%2Fczjtz9X7SfWd09oZLO2ddjrj7%2BtLAKJysIDYwefRvVP2Yvl7myOMXbI3ZAa8NSzg6BvOEUNmiJx9DZzGrlvpwxzlHDkf2H1pWoZYC1cxB3KY3Wsshh6ZQytQQOh7Ypal47ddAeeNMYnlNAsotrPLhI2oeG7Gd7lKn%2FD3UI5C9QeEnTkydfeu3SuIM48qmxBZuEMdgcrFWK4kt2kwgMYydl4if0fTeGMLLENIrqtXSfuwnMeLNSNr5bLBnviNheE1%2FiWd8ABrvBtMjaNJNHrW4fOs%2F8sBhzAZH4LG8OYZedCN9waFfdO898TWUNVq06peuYLWSC1ouZU%2F8bOuQGgOZhfMR8wn6aGuQY6twI%2B1pYhDdSOoLPAt3McHgo4IqldoPD7goZGMatzzjfoz06IxVvDlvuf6Oq5Zh4Vccetd22hSvCzKYH9vugzC7RqU5ZqvKatZRWnugr3X%2B2z%2BEQFNpvuKN%2BVTGxoTeyYUCHj6zprfu2iaJ06WXYZJp2GZXl%2BVTwIe7i%2FMxdTEe6E8f8muvCQEnH13QEMQKogV86US73AxzcYpqP8zY5zrrXv1ebJS1xbSlO8D4RYFkhw9RW%2BcQJv8aWMqmc0HH0W7qI2bwi9C2UWk%2FIyj%2FXcjCWoYa43WgINACKSWkZJ3qayRARnxk4p93gTXEC0DsZFMqcZTlbxHEn5bX6gP5SilMCfB43y9oBVB2LPji%2BG5aN7ftndAgyv24kUT%2F0I2pc0urSDHFeYvkEN75%2B%2FCqUa9Zxg1TB1gK7FXQ%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA5JVHDXRYMA5AODUL%2F20241030%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241030T023925Z&X-Amz-Expires=43200&X-Amz-SignedHeaders=host&X-Amz-Signature=010601028d78c5f02bc6f4fb011933bbf761075d020bcc5af97c770051fa4a91',
      'title': 'Un pinchi gato brincando',
      'description': 'Improvisando con mi guitarra en las calles de Madrid #música #street'
    },
    {
      'username': 'Juan Pérez',
      'userhandle': '@juanperez',
      'profileImage': 'https://i.kym-cdn.com/photos/images/facebook/002/295/694/056.jpg',
      'videoUrl': 'https://kenstudioucket.s3.us-east-1.amazonaws.com/Mon%20Laferte%20-%20La%20Nave%20Del%20Olvido%20%28Letra_Lyrics%29%20_%20Homenaje%20a%20Jos%C3%A9%20Jos%C3%A9%2C%20Vive%20Lat.mp4?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEPP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQDgO%2BDGZPqOxer6VLEl5l6Bw1QQVzK1PpPlOGoTRQpjSgIhAKQA%2BIkfM6Q3i7e5gxJNLdGBDYuetoiMzXizHNEd5E5yKuMDCGwQARoMOTE0MTA0NzYxNDU2IgzKHIcY0azqYg5yS1UqwAMDOpSW%2FtBKbVBIfde6L3JprV%2F6zQftk6l%2BgkJMc8JK7P8hN9KlBOhrzjHuDR3gNNLPHcdGBQSOtatKt3YZ45HJO%2Bk8xV7kqCG%2F5%2Bf4dNf%2FGGtFVDPIDq6DFEwkMkJnOey9J1RWinVjYvZl2XZsqqLWq2cAUuXbZy9UKgOlJCpJJWMBF%2BrPwZvc4CqEIiiaiWWHzdc%2BH7N7UlKBLpxPZPhvI3EInPtprhTybtpcLdGH%2FiS8AUHJAz9AD9u5mkrMFS9Cfb%2BZGfJ65hnxw%2FUKJOxMemtuDe9HOP05fsUj5CrB5Ys5MXtRtDH%2BVF6ZZ72ngvIUULKu%2FBXv64uyebcZVEtuk4jo8bfmgERpb%2BA3bnqQsWH4iEZ81KESTHPoKplJBSwqlLAjnKA5UQ9U6w4yZ7UuWGb0TwzFL%2BrsRHzRbnwJ3igzF4xccAK9EMzsZbUyrgSkkD5GyBKalNK%2F8dBlGHhNHT19oRiCfOQCLkro8xv5LiXWoPB2o4VBR8q14fkyRamEXocgAFG6wHlZHcnz4jn055PlaKeqcNYIFAgwlzTdfwL0v1iXaYoGjIPOsdstS5xbP39r1WJoUf969mf9oeoeMJ%2BmhrkGOrYCaZ2LDKsMzfQgM5ibi83qyWMTkynh9c7a54T%2B7HGXqiUMZqZbnH6ahRkBPCmc19AcEDMlnZOxvN1YAdgJUnGtsweQa87Xncf8Yeov%2F0W2sH2OGbB2oHjATOn1hjPHbJ8Fk%2FtxTZDLR7QwUqAt2JfFn9T8cdEocxBM7V28X72AeC%2Bp742Rcnyy%2Fr%2FxWtnCCC3xxpmLtSJi5FwhmbfU3A2UShmUNt%2Fh80I%2BQ9HEsOpER9booe858bEY6Gz1gNAfbe570%2FhSLyvW61eiUvESRrSAfz6qzrPR0Cir7ASR93F5ERG9%2FCqGwm0IzIoeIxwihrn5j6i9ARbLx7YX16C4Ct5yjmNmx6MJKKUgRPSCwU4MWowv%2FzSmAuRzWgsT9%2B2gtCi2ywweWLzme%2FqjD%2BOVPTYLAxfXp19Z5w%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA5JVHDXRYCKHZLTMQ%2F20241030%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241030T023209Z&X-Amz-Expires=43200&X-Amz-SignedHeaders=host&X-Amz-Signature=639adf61a78aac19b25f39c0e6e8a35857e914454a826ee74ddb12da56723263',
      'title': 'Mon Laferte - Cover La nave del olvido',
      'description': 'Presentación de danza folclórica en la plaza central.'
    },
  ];
  int currentIndex = 0; // Índice del video actual
  VideoPlayerController? _controller; // Controlador para el reproductor de video

  @override
  void initState() {
    super.initState();
    _loadVideo(currentIndex); // Cargar el primer video al iniciar
  }

  // Método para cargar y reproducir el video en un índice específico
  void _loadVideo(int index) {
    // Destruir el controlador actual si existe
    if (_controller != null) {
      _controller!.dispose();
    }

    // Inicializar el controlador con la URL del video
    _controller = VideoPlayerController.network(videoUrls[index])
      ..initialize().then((_) {
        setState(() {}); // Actualiza el estado para mostrar el primer fotograma
        _controller!.play(); // Reproduce el video automáticamente
      });
  }

  @override
  void dispose() {
    _controller?.dispose(); // Liberar el controlador cuando no se use
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical, // Deslizamiento vertical
        itemCount: videoUrls.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
            _loadVideo(currentIndex); // Cargar el video cuando se cambia de página
          });
        },
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Reproductor de video
              _controller != null && _controller!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    )
                  : Center(child: CircularProgressIndicator()),

              // Controles superpuestos (íconos de "Me gusta", "Compartir", etc.)
              Positioned(
                bottom: 50,
                right: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite, color: Colors.white),
                      onPressed: () {},
                    ),
                    SizedBox(height: 20),
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.white),
                      onPressed: () {},
                    ),
                    SizedBox(height: 20),
                    IconButton(
                      icon: Icon(Icons.comment, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Nombre del video o texto descriptivo
              Positioned(
                bottom: 120,
                left: 20,
                child: Text(
                  'Video ${index + 1}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
