import '../models/portfolio.dart';

class PortfolioController {
  List<Portfolio> portfolioList = [
    Portfolio(
      name: 'Irfan Farzand',
      title: 'Flutter Developer',
      description: 'I build beautiful and performant mobile apps.',
      imageUrl: 'image/ir.png',
    ),
    // Add more portfolios as needed
  ];

  List<Portfolio> getPortfolios() {
    return portfolioList;
  }
}
