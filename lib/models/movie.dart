class Movie {
  final String id;
  final String title;
  final String genre;
  final String duration;
  final String language;
  final double rating;
  final String certificate;
  final String posterUrl;
  final String description;

  const Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.duration,
    required this.language,
    required this.rating,
    required this.certificate,
    required this.posterUrl,
    required this.description,
  });
}

const sampleMovies = <Movie>[
  Movie(
    id: 'm1',
    title: 'Dune: Part Two',
    genre: 'Adventure • Sci-Fi',
    duration: '2h 46m',
    language: 'English',
    rating: 8.7,
    certificate: 'UA 13+',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg',
    description:
        'Paul Atreides joins the Fremen on a journey of revenge and destiny across the desert planet Arrakis.',
  ),
  Movie(
    id: 'm2',
    title: 'Spider-Man: No Way Home',
    genre: 'Action • Adventure',
    duration: '2h 28m',
    language: 'English',
    rating: 8.2,
    certificate: 'UA 13+',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
    description:
        'Peter Parker faces unexpected challenges when his identity becomes public and visitors arrive from other worlds.',
  ),
  Movie(
    id: 'm3',
    title: 'The Shawshank Redemption',
    genre: 'Drama',
    duration: '2h 22m',
    language: 'English',
    rating: 8.5,
    certificate: 'A',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
    description:
        'Two prisoners develop a strong friendship while holding on to hope during their time in prison.',
  ),
  Movie(
    id: 'm4',
    title: 'Oppenheimer',
    genre: 'Drama • History',
    duration: '3h 00m',
    language: 'English',
    rating: 7.9,
    certificate: 'A',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
    description:
        'The story of scientist J. Robert Oppenheimer and his role in developing the atomic bomb.',
  ),
  Movie(
    id: 'm5',
    title: 'The Super Mario Bros. Movie',
    genre: 'Animation • Adventure • Comedy',
    duration: '1h 32m',
    language: 'English',
    rating: 7.0,
    certificate: 'U',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg',
    description:
        'Mario and Luigi travel through the Mushroom Kingdom on an exciting adventure to save Princess Peach.',
  ),
  Movie(
    id: 'm6',
    title: 'Doctor Strange in the Multiverse of Madness',
    genre: 'Action • Fantasy',
    duration: '2h 06m',
    language: 'English',
    rating: 8.1,
    certificate: 'UA 13+',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg',
    description:
        'Doctor Strange explores the multiverse and faces powerful challenges across different realities.',
  ),
];
